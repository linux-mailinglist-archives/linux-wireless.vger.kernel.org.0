Return-Path: <linux-wireless+bounces-11487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 649F595327E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 16:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9521B1C2574F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4019F49C;
	Thu, 15 Aug 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apfbk/hU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B119F470;
	Thu, 15 Aug 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730696; cv=none; b=pnwjG+zB9+mQDSvhWxZI4hRWexeRND2CN27VQr6DzlDozAiKWltM8F0k5LszVAoDt25g6q+bD12Z74aJrpW24zwz7MputZ8kzqmWdLJ6+gqRXfRUXJ8kWyLiyPtFgogfdV58fYAU2+1k5bGa4UDnw3QHxkiGLhg9jxJBcmG+Bys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730696; c=relaxed/simple;
	bh=hsIRhn+LY4Ti41CZQ1o9YBVR7CGgFLQpY2GyG4Gwj2w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eXX5DRgPBfw02f9xXAowLkxBoc0BZiZKQM5yXRUHLpM33zJB+JqM3PHAAezdct8hO/yysu/bRLT3EGJnZKiWIrXN2Jq75Ez0OjfJ17CLZIYi8S707aJUtidr1G+jKD6iGs91DHL7T91HKMyBghfwHB0ixbFVcKOgdf5brgALnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apfbk/hU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB790C4AF0C;
	Thu, 15 Aug 2024 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730695;
	bh=hsIRhn+LY4Ti41CZQ1o9YBVR7CGgFLQpY2GyG4Gwj2w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=apfbk/hUNZ2TsrJyVKKu71e8PEzOCRdAQ40+Krq7oy7t03OJSfheU+Ub7vAt4+fty
	 kyW7K9fp3CwvosWsK9PgJKILzQDSXf9wjqiRNfKBGjeIKjj94yCMZB8HT1frKoeeug
	 cNxjj5fXsDzuUCjE+z67Wcpkia3Wg20k9T1qrPBAynOl5Y2S1L8XN9mdRvFkNgBTIk
	 EOrrcujsnCqiK9Bvy199jpMJXY7q+2ico2PlxTiTIo13UtSfxnKH6LXF4ntWskg0Fj
	 q+3a5POZVI5wHFJumapD0sy8DkEGsYSWf6Q3DVP4bLB1RofwcOP31yUMl3dHvEGgFd
	 hJp8tYmcsNumQ==
From: Kalle Valo <kvalo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jeff Johnson <jjohnson@kernel.org>,  Johannes Berg
 <johannes@sipsolutions.net>,  Ath10k List <ath10k@lists.infradead.org>,
  Aditya Kumar Singh <quic_adisi@quicinc.com>,  Baochen Qiang
 <quic_bqiang@quicinc.com>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  Linux Next Mailing List
 <linux-next@vger.kernel.org>,  Wireless <linux-wireless@vger.kernel.org>
Subject: Re: linux-next: manual merge of the ath-next tree with the ath tree
References: <20240808104348.6846e064@canb.auug.org.au>
	<20240814110019.6be39d14@canb.auug.org.au>
Date: Thu, 15 Aug 2024 17:04:52 +0300
In-Reply-To: <20240814110019.6be39d14@canb.auug.org.au> (Stephen Rothwell's
	message of "Wed, 14 Aug 2024 11:00:19 +1000")
Message-ID: <87msldyj97.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> On Thu, 8 Aug 2024 10:43:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the ath-next tree got a conflict in:
>> 
>>   drivers/net/wireless/ath/ath12k/hw.c
>> 
>> between commit:
>> 
>>   38055789d151 ("wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850")
>> 
>> from the ath tree and commit:
>> 
>>   8be12629b428 ("wifi: ath12k: restore ASPM for supported hardwares only")
>> 
>> from the ath-next tree.
>> 
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>> 
>> diff --cc drivers/net/wireless/ath/ath12k/hw.c
>> index 7b0b6a7f4701,76c0e07a88de..000000000000
>> --- a/drivers/net/wireless/ath/ath12k/hw.c
>> +++ b/drivers/net/wireless/ath/ath12k/hw.c
>> @@@ -925,7 -925,7 +925,9 @@@ static const struct ath12k_hw_params at
>>   		.acpi_guid = NULL,
>>   		.supports_dynamic_smps_6ghz = true,
>>   
>>  +		.iova_mask = 0,
>> ++
>> + 		.supports_aspm = false,
>>   	},
>>   	{
>>   		.name = "wcn7850 hw2.0",
>> @@@ -1003,7 -1003,7 +1005,9 @@@
>>   		.acpi_guid = &wcn7850_uuid,
>>   		.supports_dynamic_smps_6ghz = false,
>>   
>>  +		.iova_mask = ATH12K_PCIE_MAX_PAYLOAD_SIZE - 1,
>> ++
>> + 		.supports_aspm = true,
>>   	},
>>   	{
>>   		.name = "qcn9274 hw2.0",
>> @@@ -1077,7 -1077,7 +1081,9 @@@
>>   		.acpi_guid = NULL,
>>   		.supports_dynamic_smps_6ghz = true,
>>   
>>  +		.iova_mask = 0,
>> ++
>> + 		.supports_aspm = false,
>>   	},
>>   };
>>   
>
> This is now a conflict between the wireless-next tree and the ath tree.

Thanks. The plan is that the network maintainers will fix this once the
commits "meet" in net-next. We are trying to avoid unnessary merges.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

