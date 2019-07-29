Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1001D78707
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 10:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfG2IMQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 04:12:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfG2IMQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 04:12:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDFD830862BE;
        Mon, 29 Jul 2019 08:12:15 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0624560A9D;
        Mon, 29 Jul 2019 08:12:13 +0000 (UTC)
Date:   Mon, 29 Jul 2019 10:12:11 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        briannorris@chromium.org
Subject: Re: [PATCH v2 5/5] rtw88: add BT co-existence support
Message-ID: <20190729081211.GB2066@redhat.com>
References: <1564023211-3138-1-git-send-email-yhchuang@realtek.com>
 <1564023211-3138-6-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564023211-3138-6-git-send-email-yhchuang@realtek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 29 Jul 2019 08:12:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 25, 2019 at 10:53:31AM +0800, yhchuang@realtek.com wrote:
> +static struct sk_buff *rtw_coex_info_request(struct rtw_dev *rtwdev,
> +					     struct rtw_coex_info_req *req)
> +{
> +	struct rtw_coex *coex = &rtwdev->coex;
> +	struct sk_buff *skb_resp = NULL;
> +
> +	mutex_lock(&coex->mutex);
> +
> +	rtw_fw_query_bt_mp_info(rtwdev, req);
> +
> +	if (!wait_event_timeout(coex->wait, !skb_queue_empty(&coex->queue),
> +				COEX_REQUEST_TIMEOUT)) {
> +		rtw_err(rtwdev, "coex request time out\n");
> +		goto out;
> +	}
> +
> +	skb_resp = skb_dequeue(&coex->queue);
> +	if (!skb_resp) {
> +		rtw_err(rtwdev, "failed to get coex info response\n");
> +		goto out;
> +	}
> +
> +out:
> +	mutex_unlock(&coex->mutex);
> +	return skb_resp;
> +}
> +
> +static bool rtw_coex_get_bt_scan_type(struct rtw_dev *rtwdev, u8 *scan_type)
> +{
> +	struct rtw_coex_info_req req = {0};
> +	struct sk_buff *skb;
> +	u8 *payload;
> +	bool ret = false;
> +
> +	req.op_code = BT_MP_INFO_OP_SCAN_TYPE;
> +	skb = rtw_coex_info_request(rtwdev, &req);
> +	if (!skb)
> +		goto out;
> +
> +	payload = get_payload_from_coex_resp(skb);
> +	*scan_type = GET_COEX_RESP_BT_SCAN_TYPE(payload);
> +	ret = true;
> +
> +out:
> +	return ret;
> +}
> +
> +static bool rtw_coex_set_lna_constrain_level(struct rtw_dev *rtwdev,
> +					     u8 lna_constrain_level)
> +{
> +	struct rtw_coex_info_req req = {0};
> +	struct sk_buff *skb;
> +	bool ret = false;
> +
> +	req.op_code = BT_MP_INFO_OP_LNA_CONSTRAINT;
> +	req.para1 = lna_constrain_level;
> +	skb = rtw_coex_info_request(rtwdev, &req);
> +	if (!skb)
> +		goto out;

Those coex response skb buffers are allocated in rtw_pci_rx_isr(),
but I do not see where they are freed (seems we do not process
them in c2h_work which does dev_kfree_skb()).

Stanislaw
