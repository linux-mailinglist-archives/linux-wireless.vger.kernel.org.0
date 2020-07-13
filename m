Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D6F21D76D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2020 15:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgGMNoc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jul 2020 09:44:32 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53194 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728950AbgGMNoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jul 2020 09:44:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594647871; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=oE5b6st5zFOL6uFm/6SHOr6+vQonImRge0LAfmuZgBY=; b=wwk3RIgbKV3trk9GkRKkLKsAncwEEjVgSJMbc+K8/i79bXC8Id4YuYb/HAkQKEANJqoDR6/p
 v9Odv075usiqZwdDoLOrFIWAPGxXMnsemWA4CNynMm8WnZaKLa6LqPC2ye8ujvvWaVThPVux
 x5qZakrl18Xu/VKwHyQBEnsyvQc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f0c653fc9bd2efa2ecffdef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Jul 2020 13:44:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA9FCC43391; Mon, 13 Jul 2020 13:44:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FF84C433C8;
        Mon, 13 Jul 2020 13:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FF84C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
Cc:     helgaas@kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, bjorn@helgaas.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/14 v3] iwlegacy: Check the return value of pcie_capability_read_*()
References: <20200710212026.27136-1-refactormyself@gmail.com>
        <20200710212026.27136-5-refactormyself@gmail.com>
Date:   Mon, 13 Jul 2020 16:44:26 +0300
In-Reply-To: <20200710212026.27136-5-refactormyself@gmail.com> (Saheed Olayemi
        Bolarinwa's message of "Fri, 10 Jul 2020 23:20:16 +0200")
Message-ID: <87wo37a5s5.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

Saheed Olayemi Bolarinwa <refactormyself@gmail.com> writes:

> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
>
> Cc: bjorn@helgaas.com,
> 	skhan@linuxfoundation.org,
> 	linux-pci@vger.kernel.org,
> 	linux-kernel-mentees@lists.linuxfoundation.org,
> 	linux-kernel@vger.kernel.org,
> 	Stanislaw Gruszka <stf_xl@wp.pl>,
> 	linux-wireless@vger.kernel.org,
> 	netdev@vger.kernel.org
>
> On failure pcie_capability_read_dword() sets it's last parameter, val
> to 0. However, with Patch 14/14, it is possible that val is set to ~0 on
> failure. This would introduce a bug because (x & x) == (~0 & x).
>
> This bug can be avoided without changing the function's behaviour if the
> return value of pcie_capability_read_dword is checked to confirm success.
>
> Check the return value of pcie_capability_read_dword() to ensure success.
>
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

Please check your setup, linux-wireless was not in Cc field.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
