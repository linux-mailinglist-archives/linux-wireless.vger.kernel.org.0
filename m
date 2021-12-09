Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5667F46ECB7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbhLIQLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 11:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbhLIQLG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 11:11:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8CC061B38
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 08:07:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D125BCE26C5
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 16:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F994C004DD;
        Thu,  9 Dec 2021 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639066049;
        bh=QCfB1mvMTh0V1PcUo+MWU8dN62cEufkqQVYOA2m8uvk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=H6mi4U+guBFBGURzaZS3BNm2ESfqf1fik/rYmMuSMK6CRfcqatu/kCM4BzYDqgb1Y
         dUNrB6T8lIwxUIC7sS1i1+gdzMf/cv1SVpuP9yVQsST8NMyRAc2G7i7Z9kJkKVD9dm
         5N8fKA875JCIxh68RFo8OijNwkL35XSrG/+ToBFxUl51OnZCLHrRdqeWVu0KvcOLMw
         cupF2e/t/fy1YQzVyqh4NR6wwMWRaRYhk4XPZ0A7UbGsx5sZkIyxTYWwbGAD6odyAA
         67stpxAdfpppqHlCBY0lQuU7zXruiKJWmf8laXboWoz+f8ESKpHyHV8o+G0iGQFbNb
         eC61Te9ZtRqjA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5/6] ath11k: support ARP and NS offload
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <20211011193750.4891-6-cjhuang@codeaurora.org>
Date:   Thu, 09 Dec 2021 18:07:26 +0200
In-Reply-To: <20211011193750.4891-6-cjhuang@codeaurora.org> (Carl Huang's
        message of "Mon, 11 Oct 2021 15:37:49 -0400")
Message-ID: <87h7bhyd6p.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> writes:

> Support ARP and NS offload in WoW state.
>
> Tested this way: put machineA with QCA6390 to WoW state,
> ping/ping6 machineA from another machineB, check sniffer to see
> any ARP response and Neighbour advertisement from machineA.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>

[...]

> +static int ath11k_wow_protocol_offload(struct ath11k *ar, bool enable)
> +{
> +	int ret;
> +
> +	ret = ath11k_wow_arp_ns_offload(ar, enable);
> +
> +	return ret;

For consistency, please add error handling for
ath11k_wow_arp_ns_offload().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
