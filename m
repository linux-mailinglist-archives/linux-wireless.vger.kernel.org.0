Return-Path: <linux-wireless+bounces-18144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E45A21CCC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 12:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF42C3A76AF
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5711C831A;
	Wed, 29 Jan 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="FrGNJGhx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1C1BD007;
	Wed, 29 Jan 2025 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151803; cv=none; b=HyPRu5q+BuIARGnpgs4ykmvtgSl4U7/IHODk7B82EJpisPjzW8pPvdx+oosEi4kSGYJrYHMbb0s64KadKtImUyN8Jen5QyBcXCp6x/iKJLZIK8NKv17Vm9+q/81GZ0+8aLCJkJRDzGmnFNeo3VObTX1Ra23OpPMxnFzhd7LaqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151803; c=relaxed/simple;
	bh=wE9jWyFd1b3UACwyfBErLDYaZMqPYfhGjiMBUJGGYpw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=URN4WKkbpWK1csnwwt6Qghlf5r9/e0iAcszr8ZUulgb8Af/Fr6m6MqvsPGja7VRdiOfG+q480sothWISguvgHQOvNCtYOSUZAIjDmVsed5/9JHgLUXn6dCJBM/1CRPMCnJ26baBqZaF5Hj9T/SZMk8a+FJS/vmbGaGcDLlEIIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=FrGNJGhx; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:c:0:640:bd4a:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id D0D8061A3C;
	Wed, 29 Jan 2025 14:50:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HocYHI8OmqM0-2ooCYqPw;
	Wed, 29 Jan 2025 14:50:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738151419; bh=6bXVcXuRvFT9i7bAH3dfCAQMGE1LXEeA2uARmJsIq9w=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=FrGNJGhxsV5ssI6R+OZ7z4yoUgvHhaVr9wiGpaOvZ3XB91G+1g5hhYHdlqw3BHDpw
	 iCpu+5lvpvMQCVDcUN2Ak9Y+KmdGwrzeYid+t1KnLc4dVpAZykT20suyOFsnGhzn65
	 xIqGu+53+TYbmADXGfTXCzDTG0CFhoFAJTJy/c5Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <c3861593-7905-421b-8833-989e6a4e3c3c@yandex.ru>
Date: Wed, 29 Jan 2025 14:50:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250129103120.1985802-1-dmantipov@yandex.ru>
 <1bc323264d3118434fa748efa59ed4da9dba6157.camel@sipsolutions.net>
Content-Language: en-MW
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: Re: [PATCH 6.1] wifi: iwlwifi: assume known PNVM power table size
In-Reply-To: <1bc323264d3118434fa748efa59ed4da9dba6157.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/25 1:48 PM, Johannes Berg wrote:

> I don't see that there's uninitialized use of 'len'. Maybe some static
> checkers aren't seeing through this, but the code is fine:
> 
> If iwl_pnvm_get_from_fs() is successful, then 'len' is initialized. If
> it fails, we goto skip_parse.
> 
> There, if trans->reduce_power_loaded is false, 'len' again is either
> initialized or we go to skip_reduce_power and never use 'len'.
> 
> If trans->reduce_power_loaded is true, then we get to
> iwl_trans_pcie_ctx_info_gen3_set_reduce_power() which doesn't use 'len'
> in this case.

Hm. As of 6.1.127, what I'm seeing is ('cat -n' annotated by me):

    258	int iwl_pnvm_load(struct iwl_trans *trans,
    259			  struct iwl_notif_wait_data *notif_wait)
    260	{
    261		u8 *data;
    262		size_t len;                                                     /* uninitialized */
    263		struct pnvm_sku_package *package;
    264		struct iwl_notification_wait pnvm_wait;
    265		static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
    266							PNVM_INIT_COMPLETE_NTFY) };
    267		int ret;
    268	
    269		/* if the SKU_ID is empty, there's nothing to do */
    270		if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
    271			return 0;
    272	
    273		/*
    274		 * If we already loaded (or tried to load) it before, we just
    275		 * need to set it again.
    276		 */
    277		if (trans->pnvm_loaded) {
    278			ret = iwl_trans_set_pnvm(trans, NULL, 0);
    279			if (ret)
    280				return ret;
    281			goto skip_parse;                                        /* taking goto */
    282		}
    283	
    284		/* First attempt to get the PNVM from BIOS */
    285		package = iwl_uefi_get_pnvm(trans, &len);
    286		if (!IS_ERR_OR_NULL(package)) {
    287			if (len >= sizeof(*package)) {
    288				/* we need only the data */
    289				len -= sizeof(*package);
    290				data = kmemdup(package->data, len, GFP_KERNEL);
    291			} else {
    292				data = NULL;
    293			}
    294	
    295			/* free package regardless of whether kmemdup succeeded */
    296			kfree(package);
    297	
    298			if (data)
    299				goto parse;
    300		}
    301	
    302		/* If it's not available, try from the filesystem */
    303		ret = iwl_pnvm_get_from_fs(trans, &data, &len);
    304		if (ret) {
    305			/*
    306			 * Pretend we've loaded it - at least we've tried and
    307			 * couldn't load it at all, so there's no point in
    308			 * trying again over and over.
    309			 */
    310			trans->pnvm_loaded = true;
    311	
    312			goto skip_parse;
    313		}
    314	
    315	parse:
    316		iwl_pnvm_parse(trans, data, len);
    317	
    318		kfree(data);
    319	
    320	skip_parse:
    321		data = NULL;
    322		/* now try to get the reduce power table, if not loaded yet */
    323		if (!trans->reduce_power_loaded) {                              /* the condition is false */
    324			data = iwl_uefi_get_reduced_power(trans, &len);
    325			if (IS_ERR_OR_NULL(data)) {
    326				/*
    327				 * Pretend we've loaded it - at least we've tried and
    328				 * couldn't load it at all, so there's no point in
    329				 * trying again over and over.
    330				 */
    331				trans->reduce_power_loaded = true;
    332	
    333				goto skip_reduce_power;
    334			}
    335		}
    336	
    337		ret = iwl_trans_set_reduce_power(trans, data, len);             /* len - ? */
    338		if (ret)
    339			IWL_DEBUG_FW(trans,
    340				     "Failed to set reduce power table %d\n",
    341				     ret);
    342		kfree(data);

Am I missing something?

Dmitry


