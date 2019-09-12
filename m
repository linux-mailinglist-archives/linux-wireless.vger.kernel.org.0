Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81682B102B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 15:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfILNmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 09:42:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731650AbfILNmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 09:42:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B7F1607CA; Thu, 12 Sep 2019 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568295722;
        bh=Gjz7qFe3GqZ9wYkOJyZqf5Epxw35IB5gqGpCWz3xNWY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Uqx0buhKAg6qhPc464+t8SEXT86DP27khnRjMxxPPHTgbMd+4feYpCbptiRourzxR
         DNRAEIDdWfIhArKJKvyjS6FekHQ1Zx8t1ooxFqb8rjpNsp3SMXfIbKH9YD3BFmI5Hu
         3t9zXaawpo95hYujv68j6N+m9MgK8LaDWK1XJbQ0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2F0A602F8;
        Thu, 12 Sep 2019 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568295722;
        bh=Gjz7qFe3GqZ9wYkOJyZqf5Epxw35IB5gqGpCWz3xNWY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Uqx0buhKAg6qhPc464+t8SEXT86DP27khnRjMxxPPHTgbMd+4feYpCbptiRourzxR
         DNRAEIDdWfIhArKJKvyjS6FekHQ1Zx8t1ooxFqb8rjpNsp3SMXfIbKH9YD3BFmI5Hu
         3t9zXaawpo95hYujv68j6N+m9MgK8LaDWK1XJbQ0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2F0A602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: Fix channel info parsing for non tlv target
References: <1552044366-9186-1-git-send-email-pillair@codeaurora.org>
Date:   Thu, 12 Sep 2019 16:41:58 +0300
In-Reply-To: <1552044366-9186-1-git-send-email-pillair@codeaurora.org> (Rakesh
        Pillai's message of "Fri, 8 Mar 2019 16:56:06 +0530")
Message-ID: <87r24lk4wp.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> writes:

> The tlv targets such as WCN3990 send more data in
> the chan info event, which is not sent by the non tlv
> targets. There is a minimum size check in the wmi event for
> non-tlv targets and hence we cannot update the common
> channel info structure.
>
> If the common channel info structure is updated, the
> size check for chan info event for non-tlv targets
> will fail and return -EPROTO

This is the code in question:

static int ath10k_wmi_op_pull_ch_info_ev(struct ath10k *ar, struct sk_buff *skb,
					 struct wmi_ch_info_ev_arg *arg)
{
	struct wmi_chan_info_event *ev = (void *)skb->data;

	if (skb->len < sizeof(*ev))
		return -EPROTO;

	skb_pull(skb, sizeof(*ev));
	arg->err_code = ev->err_code;
	arg->freq = ev->freq;
	arg->cmd_flags = ev->cmd_flags;
	arg->noise_floor = ev->noise_floor;
	arg->rx_clear_count = ev->rx_clear_count;
	arg->cycle_count = ev->cycle_count;

	return 0;
}

And here I see a disconnection between firmware and ath10k. The design
philosophy in firmware is that if the firmware does not provide all
fields, for example cycle_count in this event, the host driver is
supposed to replace the missing field with value zero and continue
normally. Obviously ath10k does not do that and instead it drops the
whole WMI event, which causes breakup like this.

The quick fix (having separate structs for TLV and 10.x interfaces) in
this patch is ok, but in the future if similar field additions arise we
need to remember to fix ath10k event parsing so that both new ath10k
will continue to work with older firmwares.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
