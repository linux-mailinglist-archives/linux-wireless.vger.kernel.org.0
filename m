Return-Path: <linux-wireless+bounces-36392-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA1mLgHABGoeNgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36392-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 20:16:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4CA538BB8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 20:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 425143010670
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 18:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941F378D8C;
	Wed, 13 May 2026 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM64SEcV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433323F4115;
	Wed, 13 May 2026 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696189; cv=none; b=g3tCerua+kLMg2CowNWvkqW4ijlFnw+tsS/qEkwghbwvgMTksaTxQRhK6K9qVinpKJRWMkZiJZX5AoO1w1n6zjFh1GM6W5cAehJv2Se9ZxBkRt1qXw+tRPqHW8NUfXxrh7damf13lTRoH2zaILKIaohvNF04MZLrJAq15zvIE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696189; c=relaxed/simple;
	bh=3llgRJ9rM94AnLULhT58OrpcTkA18s5QGlESv6m9e1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMig2zzs8yF83F/qMdMZU58T2WVjL969JY9EsJTgssdKnKfqqUXKYkgHYHquHsh67Z2b4YZU0a1jeEUrWgyTjR0ZKiL8ma2Vojm4fskWZIfdFPc/1LgZj1oOu+VnXwWwwgbKi8F8ZvX0ZgZeQCH2XV44Uaa4G6xZoET6BoPfEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM64SEcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2F9C19425;
	Wed, 13 May 2026 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778696188;
	bh=3llgRJ9rM94AnLULhT58OrpcTkA18s5QGlESv6m9e1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MM64SEcVLEXM1v0XH+bed/phFVq1O3wEtVMc0ykrSDJtQZbHaNnmXkKOFE+LnX1wQ
	 ejUi4ZNlVi0gN3yBo4dzzN3qQa/2620xGabs9eu9LEV7mo1+/MkgzcryXKn1B0j0EC
	 WbiVGsIGHYylQvUc6rLfrZtrFYPWucHBoLpef+7dFO1RUxYRnuW99v8r9xlzmRUpYz
	 3kemM0Lgjx8132hv+8hVN48zoLeEq1LA1WnGcz2cU6VPpD8lyVHC3a/0Q/dfBVlGIw
	 Y0PUi36jJ+bi3fvsW3dwjdRcYrNmrpLqUogKou4K15KvTlYOlt56PtfE080prKrOH8
	 wBU/jKRrjntww==
Message-ID: <6b722eda-a22e-4037-86c3-7f1231022af9@kernel.org>
Date: Wed, 13 May 2026 20:16:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] wifi: iwlwifi: dt: add Device Tree BIOS
 configuration infrastructure
To: "Bhatt, Avinash" <avinash.bhatt@intel.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Guetta, Kobi" <kobi.guetta@intel.com>,
 "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
References: <20260504095327.30892-1-avinash.bhatt@intel.com>
 <20260504095327.30892-3-avinash.bhatt@intel.com>
 <20260505-sincere-electric-lobster-2a7bc3@quoll>
 <BL1PR11MB595490A72F8319FBB23194F1E0392@BL1PR11MB5954.namprd11.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <BL1PR11MB595490A72F8319FBB23194F1E0392@BL1PR11MB5954.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B4CA538BB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36392-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 12/05/2026 12:03, Bhatt, Avinash wrote:
> Hi Krzysztof,
> 
> Thank you for the review. Please find our response inline below.
> We have made several changes in the driver as part of v3 and will be
> sending it shortly.
> 
> On Mon, May 04, 2026 at 12:53:26PM +0300, Krzysztof Kozlowski wrote:
>> +static const char *dsm_func_to_prop_name(enum iwl_dsm_funcs func) {
>> +	switch (func) {
>> +	case DSM_FUNC_DISABLE_SRD:          return IWL_DT_PROP_SRD;
>> +	case DSM_FUNC_ENABLE_6E:            return IWL_DT_PROP_6E_UHB;
>> ...
>>
>> Pointless function and only making DT ABI checks difficult. Drop.
>> Don't invent API wrappers or other HAL over simple calls to OF or
>> device API.
>> Drop also ALL defines and use OF API like EVERY other driver.
> 
> Fixed in v3. Removed dsm_func_to_prop_name() and all IWL_DT_PROP_*
> defines. iwl_dt_get_dsm() now dispatches via a direct switch on the
> function index to individual per-property functions (iwl_dt_get_srd(),
> iwl_dt_get_6e_uhb(), etc.), each calling of_property_read_*() directly
> with the literal property string — consistent with how every other
> driver uses the OF API.
> 
> Best Regards,
> Avinash
> 
> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org> 
> Sent: 05 May 2026 14:48
> To: Bhatt, Avinash <avinash.bhatt@intel.com>
> Cc: devicetree@vger.kernel.org; linux-wireless@vger.kernel.org; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; johannes@sipsolutions.net; Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>; linux-kernel@vger.kernel.org; Guetta, Kobi <kobi.guetta@intel.com>; Grumbach, Emmanuel <emmanuel.grumbach@intel.com>
> Subject: Re: [PATCH v2 2/3] wifi: iwlwifi: dt: add Device Tree BIOS configuration infrastructure
> 
> On Mon, May 04, 2026 at 12:53:26PM +0300, Avinash Bhatt wrote:
>> +
>> +/*
>> + * Mapping from DSM function index to Device Tree property name.
>> + * Returns the DT property name for a given DSM function, or NULL if 
>> +the
>> + * function has no Device Tree representation.
>> + */
>> +static const char *dsm_func_to_prop_name(enum iwl_dsm_funcs func) {
>> +	switch (func) {
>> +	case DSM_FUNC_DISABLE_SRD:          return IWL_DT_PROP_SRD;
>> +	case DSM_FUNC_ENABLE_6E:            return IWL_DT_PROP_6E_UHB;
>> +	case DSM_FUNC_REGULATORY_CONFIG:    return IWL_DT_PROP_REG_SPECIAL;
>> +	case DSM_FUNC_ACTIVATE_CHANNEL:     return IWL_DT_PROP_ACTIVATE_CH;
>> +	case DSM_FUNC_FORCE_DISABLE_CHANNELS:
>> +		return IWL_DT_PROP_FORCE_DISABLE_CH;
>> +	case DSM_FUNC_ENABLE_11BE:          return IWL_DT_PROP_11BE;
>> +	default:                            return NULL;
> 
> Pointless function and only making DT ABI checks difficult. Drop.
> 
> Don't invent API wrappers or other HAL over simple calls to OF or device API.
> 
> Drop also ALL defines and use OF API like EVERY other driver. This is not a special place.
> 

What is this style of answering? Am I replying now to my own email?

Best regards,
Krzysztof

