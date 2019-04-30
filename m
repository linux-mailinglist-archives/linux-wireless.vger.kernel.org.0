Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8FF89A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 14:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfD3MQb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 08:16:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33700 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfD3MQb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 08:16:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CD9196029B; Tue, 30 Apr 2019 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556626590;
        bh=rnSRYT4eh/SMsw0h371bavfrU4OTDmEoj5s5HdfzUD4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Obmc8mmL21e+0gZImhXkRNusm5Wi6R3ObeVGG2bMsZpNMD58zb+RbsOg3mP14Q3BF
         S3NAmDho4dLvkR7wOJUbhN7GwdCh4vPKO7uuYHPGze2VyuNJvDOs0tIbABz7IK+p3u
         MwCxInxDMNT3gudYr69IlLFYqaZm/nGNYbq8tIUM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F342D6029B;
        Tue, 30 Apr 2019 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556626590;
        bh=rnSRYT4eh/SMsw0h371bavfrU4OTDmEoj5s5HdfzUD4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Obmc8mmL21e+0gZImhXkRNusm5Wi6R3ObeVGG2bMsZpNMD58zb+RbsOg3mP14Q3BF
         S3NAmDho4dLvkR7wOJUbhN7GwdCh4vPKO7uuYHPGze2VyuNJvDOs0tIbABz7IK+p3u
         MwCxInxDMNT3gudYr69IlLFYqaZm/nGNYbq8tIUM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F342D6029B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <pkshih@realtek.com>, <tehuang@realtek.com>,
        <Larry.Finger@lwfinger.net>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 01/14] rtw88: main files
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        <1555653004-1795-2-git-send-email-yhchuang@realtek.com>
Date:   Tue, 30 Apr 2019 15:16:25 +0300
In-Reply-To: <1555653004-1795-2-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 19 Apr 2019 13:49:51 +0800")
Message-ID: <87ftpzpu1y.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> main files for Realtek 802.11ac wireless network chips
>
> Reviewed-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> +static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
> +{
> +	__le16 fc = hdr->frame_control;
> +	u8 *bssid;
> +
> +	if (ieee80211_has_tods(fc))
> +		bssid = hdr->addr1;
> +	else if (ieee80211_has_fromds(fc))
> +		bssid = hdr->addr2;
> +	else
> +		bssid = hdr->addr3;
> +
> +	return bssid;
> +}

I wonder should something like this be in include/linux/ieee80211.h?

-- 
Kalle Valo
