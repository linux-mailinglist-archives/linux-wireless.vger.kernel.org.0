Return-Path: <linux-wireless+bounces-8437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B198D8AC1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 22:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B45D1C22301
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 20:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFFF13B580;
	Mon,  3 Jun 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frAxb16d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680D135A5A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445517; cv=none; b=c30IzDJIQ+cKfd3LTxm1vjaiElYjmOSaaSCdCIMyS19eipom3TdiGhloXTKq4v3wEoyVfntaeTdUplmbdEjP8j0hxSrjm0Oqzn+VKBEMa/yuUyt69ArfeW9Yhj/m12slzi6WBwhseQr1a8C0tUxcdhEKjaZrQpKnOh67dZPkzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445517; c=relaxed/simple;
	bh=pGZR0EvHvDWqai8PBnHLS0nBSNBDYKCqGmU8d6NkPs8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jnNMpjTsOfC8LGfEWCnqvSs+Bi05gCMt+DzfM15szxhoSc+moS/Sz+oayYCeJ7FeVpmXflu9uqsNrTafPCCUDEaXf7jIHhQcCI4uXv9dRxu3LYUM3TnfjwvIAjBPmyDrwpu4AanFM3qLuK9QoN5gSuFWbkpNHORqAmNqqR7dUHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frAxb16d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21E3C32782;
	Mon,  3 Jun 2024 20:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717445517;
	bh=pGZR0EvHvDWqai8PBnHLS0nBSNBDYKCqGmU8d6NkPs8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=frAxb16dDKVqKH15L+a8G2eMgz0PUmxfu47KRyVDx4wjhqL3GSYW2/oWTq7ujcrXo
	 tftIRnzqqCMgpENwVgx7CV7by3XOPtAS5s8icqkviZRnl9MI/Uud1clY0ZIAV80iUL
	 aNWjkLJmC3wqKFosgbioz0JB1b54FvQbLwLnqjEey+gD8WvEi2pXpgDuhmEuo3aMtm
	 ocL8m/LjE3oD1X25As62D18M+emV7lhlC5N2WqsWXbvgmPryEE7uwM/o/3mqHKZ1lw
	 DWD6uUmpr9Odku+gtDR9DKPxl2JFo0EsL47TYAXZYIlGBkyRhhbKVnNGXDt4UjmhPb
	 tthHQidiL3WGw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath10k <ath10k@lists.infradead.org>,  ath11k
 <ath11k@lists.infradead.org>,  ath12k <ath12k@lists.infradead.org>,
  linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: New staging repos for ath1*k firmware
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
	<878r09gfzv.fsf@kernel.org>
Date: Mon, 03 Jun 2024 23:11:53 +0300
In-Reply-To: <878r09gfzv.fsf@kernel.org> (Kalle Valo's message of "Fri, 17 May
	2024 08:32:52 +0300")
Message-ID: <87ed9dn5va.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>
>> Historically, prior to being incorporated into the linux-firmware
>> project, firmware for kernel.org ath1*k drivers has been first published
>> to Kalle's GitHub:
>> https://github.com/kvalo/ath10k-firmware
>> https://github.com/kvalo/ath11k-firmware
>> (ath12k firmware was pushed to the ath11k-firmware repo on a temporary
>> basis in anticipation of this move)
>>
>> But in order to have repos with multiple maintainers, as well as to have
>> a hosting platform with more control, we have moved to CodeLinaro:
>> https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware
>> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware
>> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware
>>
>> Note that most people should not care about this -- normally you should
>> use the firmware that is in the official linux-firmware repo:
>> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/
>>
>> You should only need to access the staging repos if you need a previous
>> version to work around an issue, or if you are testing new firmware that
>> is supposed to fix a problem that you've reported.
>>
>> Please let Kalle & I know if you have any issues with these new repos!
>
> The final reminder that the github.com repositories will be deleted in
> two weeks. If someone is still using them switch to the new
> git.codelinaro.org location NOW.

And github.com repos are gone now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

