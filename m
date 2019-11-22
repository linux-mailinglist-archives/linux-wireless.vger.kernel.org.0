Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B23106978
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 11:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKVKCh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 05:02:37 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:34066
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbfKVKCg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 05:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574416955;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=AlNw6b30Bh8L6QhdL0cnrdZTD8RXiY/LEYyCbwFLZtk=;
        b=Va+53ZzADMJ9n0k0URDdi0c/9G+2lJgExTq6XX/tywDrSWJ8vQunvaq0bXhWUghg
        cBdGS4wjW4B5SI7qvOgiazqPDKgvOwYeR647kpOgVo4BDIO6BPjBtmFhr6mc89qnY4O
        7M9rOL78By/oss54DkLpaQFfAbQuTM2KTLhkO9SA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574416955;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=AlNw6b30Bh8L6QhdL0cnrdZTD8RXiY/LEYyCbwFLZtk=;
        b=HWk9NPRZJEKKKixQigN4W0nZDC667vg/yp+V1B6Rk+J7+oyqr1OB+FtX885Xqd4s
        f/kO3t51G/VfJZuZCdiWMQeQ3ljTRe9HlVHe2Gazu7+lzUjjUGT+FBZWdAYN4BIDZ1P
        fgWJf6TOptAJn9f/QLALeEcsHNsHoZXtA6WASuLY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A76B0C92FED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v6 3/3] ath10k: add workqueue for RX path of sdio
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
        <1569402639-31720-4-git-send-email-wgong@codeaurora.org>
        <8736f92sfx.fsf@kamboji.qca.qualcomm.com>
        <3f3641ad49a2664d346558760e38b404@codeaurora.org>
        <70f8f208f631a2a2c7337f45b873a16e@codeaurora.org>
        <87r22ewqi6.fsf@codeaurora.org>
        <ee6539c50cff626968984df3b511a5a8@codeaurora.org>
Date:   Fri, 22 Nov 2019 10:02:35 +0000
In-Reply-To: <ee6539c50cff626968984df3b511a5a8@codeaurora.org> (Wen Gong's
        message of "Wed, 13 Nov 2019 11:37:57 +0800")
Message-ID: <0101016e929037fa-4b760ae2-b670-4922-b86e-32a7cd083717-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SES-Outgoing: 2019.11.22-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2019-11-11 20:23, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> writes:
>>
>>> On 2019-11-01 15:42, Wen Gong wrote:
>>>> On 2019-10-31 17:08, Kalle Valo wrote:
>>>> =E3=80=81> I just realised that this is RX path so we should use
>>>> ATH10K_SKB_RXCB()
>>>>> instead. I made the change below to this commit in pending branch:
>>>>>
>>>> I will test with the new patch together with other performance
>>>> patches.
>>> Hi Kalle, I have tested with the patches of pending branch, it is
>>> success.
>>> result is same with the public review which I tested before.
>>>
>>> the patches I tested on pending branch:
>>>
>>> ath10k: enable alt data of TX path for sdio
>>> ath10k: add htt TX bundle for sdio
>>> ath10k: disable TX complete indication of htt for sdio
>>> ath10k: enable napi on RX path for sdio
>>> ath10k: sdio: remove struct ath10k_sdio_rx_data::status
>>> ath10k: sdio: cosmetic cleanup
>>> ath10k: add workqueue for RX path of sdio
>>> ath10k: change max RX bundle size from 8 to 32 for sdio
>>> ath10k: enable RX bundle receive for sdio
>>
>> Very good, thanks for testing.
>
> this patch will trigger connect fail for PSK mode AP:
> ath10k: add workqueue for RX path of sdio
>
> I have sent patch to fix it:
> ath10k: clear ieee80211_rx_status for sdio

Good catch! But as this patch is not yet applied I fixed this patch
instead with this:

--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2235,7 +2235,10 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath1=
0k_htt *htt,
=20
        hdr =3D (struct ieee80211_hdr *)skb->data;
        qos =3D ieee80211_is_data_qos(hdr->frame_control);
+
        rx_status =3D IEEE80211_SKB_RXCB(skb);
+       memset(rx_status, 0, sizeof(*rx_status));
+
        rx_status->chains |=3D BIT(0);
        if (rx->ppdu.combined_rssi =3D=3D 0) {
                /* SDIO firmware does not provide signal */

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
