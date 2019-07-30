Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62FD79F7B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 05:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfG3DNs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 23:13:48 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55249 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfG3DNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 23:13:47 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6U3DawZ012778, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6U3DawZ012778
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Jul 2019 11:13:36 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Tue, 30 Jul
 2019 11:13:36 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>
Subject: RE: [PATCH v2 5/5] rtw88: add BT co-existence support
Thread-Topic: [PATCH v2 5/5] rtw88: add BT co-existence support
Thread-Index: AQHVQpRSsRYkVSzfAk6nBwJFJaXlo6bgv1+AgAHEjjA=
Date:   Tue, 30 Jul 2019 03:13:35 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D1881C82@RTITMBSVM04.realtek.com.tw>
References: <1564023211-3138-1-git-send-email-yhchuang@realtek.com>
 <1564023211-3138-6-git-send-email-yhchuang@realtek.com>
 <20190729081211.GB2066@redhat.com>
In-Reply-To: <20190729081211.GB2066@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Subject: Re: [PATCH v2 5/5] rtw88: add BT co-existence support
> 
> On Thu, Jul 25, 2019 at 10:53:31AM +0800, yhchuang@realtek.com wrote:
> > +static struct sk_buff *rtw_coex_info_request(struct rtw_dev *rtwdev,
> > +					     struct rtw_coex_info_req *req)
> > +{
> > +	struct rtw_coex *coex = &rtwdev->coex;
> > +	struct sk_buff *skb_resp = NULL;
> > +
> > +	mutex_lock(&coex->mutex);
> > +
> > +	rtw_fw_query_bt_mp_info(rtwdev, req);
> > +
> > +	if (!wait_event_timeout(coex->wait, !skb_queue_empty(&coex->queue),
> > +				COEX_REQUEST_TIMEOUT)) {
> > +		rtw_err(rtwdev, "coex request time out\n");
> > +		goto out;
> > +	}
> > +
> > +	skb_resp = skb_dequeue(&coex->queue);
> > +	if (!skb_resp) {
> > +		rtw_err(rtwdev, "failed to get coex info response\n");
> > +		goto out;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&coex->mutex);
> > +	return skb_resp;
> > +}
> > +
> > +static bool rtw_coex_get_bt_scan_type(struct rtw_dev *rtwdev, u8
> *scan_type)
> > +{
> > +	struct rtw_coex_info_req req = {0};
> > +	struct sk_buff *skb;
> > +	u8 *payload;
> > +	bool ret = false;
> > +
> > +	req.op_code = BT_MP_INFO_OP_SCAN_TYPE;
> > +	skb = rtw_coex_info_request(rtwdev, &req);
> > +	if (!skb)
> > +		goto out;
> > +
> > +	payload = get_payload_from_coex_resp(skb);
> > +	*scan_type = GET_COEX_RESP_BT_SCAN_TYPE(payload);
> > +	ret = true;
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> > +static bool rtw_coex_set_lna_constrain_level(struct rtw_dev *rtwdev,
> > +					     u8 lna_constrain_level)
> > +{
> > +	struct rtw_coex_info_req req = {0};
> > +	struct sk_buff *skb;
> > +	bool ret = false;
> > +
> > +	req.op_code = BT_MP_INFO_OP_LNA_CONSTRAINT;
> > +	req.para1 = lna_constrain_level;
> > +	skb = rtw_coex_info_request(rtwdev, &req);
> > +	if (!skb)
> > +		goto out;
> 
> Those coex response skb buffers are allocated in rtw_pci_rx_isr(),
> but I do not see where they are freed (seems we do not process
> them in c2h_work which does dev_kfree_skb()).

You're right, that SKB leaked. Should free them after responded.
I will send v2 to fix it :)

Thanks.

> 
> Stanislaw

Yan-Hsuan
