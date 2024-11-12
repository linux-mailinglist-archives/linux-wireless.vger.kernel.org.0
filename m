Return-Path: <linux-wireless+bounces-15207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7F99C5BF8
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 16:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC721F22C43
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F7201277;
	Tue, 12 Nov 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N1tOKKtK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D5201253;
	Tue, 12 Nov 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425707; cv=none; b=TzsNh4YfjmQQTshy7OTQynJJhVsrEaXWdOfY75lc/RI77SDuM85/2jcStYh1uaZmuevvT37NWhsuX3dzMKbKQ4lLchLg/U/9mzJSpDg/VaRWkpj7zWkTFL4p/1Z9uf3h7mqnJgvALZI2OcuxP9chz8RiBknn4ZfIULUaHtTG4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425707; c=relaxed/simple;
	bh=G1EL/5dFTQLrRgb48Hj4XjZL8TYLTx/GXepImuust7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DPe0tw/j0Ey9XnRNTTew+42Gs12Iw3iEp13SjLMODAaBhvbxgMFqbvNfqU+PxRWcQfDTpfvuDi2dAJG+IfSsmkgqIXnUCFApDDz+FEgAZf4+B8Nb/rF0amuKOvbegs+HW9Ru80ca0yyGlJBPcvCRk5kq3O3Xf9o5ekr6nGywzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N1tOKKtK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ACFYlGe002943;
	Tue, 12 Nov 2024 09:34:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731425687;
	bh=8MzERit/I5MynQF+dQgf1nzw3r//+UtEH+8JutqbrkQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=N1tOKKtKOwVzqV9XImxZ12Dy5wPJmJ/EUjpVqulkFVBD3ytHqCpIxI2RItcPYRbO1
	 dWq+6jBmQ3RaT8i8DbF4SqsdQppREaFyucXXlEr9pNTdWAa7rCrQH96NPbiAfvwVU7
	 YDfYblrJxM4fkuwtF0abUyM2Hv3/fEz/DOdmWv+k=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ACFYlQF043556
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Nov 2024 09:34:47 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Nov 2024 09:34:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Nov 2024 09:34:47 -0600
Received: from [137.167.6.238] (lt5cg1094w5k.dhcp.ti.com [137.167.6.238])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ACFYhX0130880;
	Tue, 12 Nov 2024 09:34:44 -0600
Message-ID: <2dbf1cba-0b16-413b-947e-dacf32c85687@ti.com>
Date: Tue, 12 Nov 2024 17:34:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/17] wifi: cc33xx: Add main.c
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
 <20241107125209.1736277-10-michael.nemanov@ti.com>
 <685d782d68bfc664c4fcc594dff96546ffc30e5f.camel@sipsolutions.net>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <685d782d68bfc664c4fcc594dff96546ffc30e5f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/8/2024 1:42 PM, Johannes Berg wrote:
> Hi,
> 
> reading through this anyway looking for mac80211 integration, so I'll
> nitpick too ... ;-)
> 

...

>> +	if (wlvif->sta.role_chan_type != NL80211_CHAN_HT40MINUS &&
>> +	    wlvif->sta.role_chan_type != NL80211_CHAN_HT40PLUS)
>> +		ieee80211_connection_loss(cc33xx_wlvif_to_vif(wlvif));
> 
> You seem to support HE (PPE thresholds above and all that), but then you
> still use CHAN_HT40MINUS/PLUS?! That seems ... rather wrong? You should
> probably track in terms of NL80211_CHAN_WIDTH_*, I'm not even sure how
> you get NL80211_CHAN_* values in the first place, mac80211 should never
> use them now?
> 

Right, a leftover from wlcore. Since CC33xx is 20 MHz only device I'll 
remove it.

...

>> +static inline void cc33xx_tx_watchdog_work(struct work_struct *work)
>> +{
>> +	container_of(to_delayed_work(work), struct cc33xx, tx_watchdog_work);
>> +}
> 
> I don't think that does what you think it does. Well, I don't know what
> you think it does, but ...
> 
> Also there should be (almost) no inline in C files, and even if it were
> correct you'd probably just use it exactly once?
> 

Agree, will get rid of inline in all functions.

...

>> +static int parse_control_message(struct cc33xx *cc,
>> +				 const u8 *buffer, size_t buffer_length)
>> +{
>> +	u8 *const end_of_payload = (u8 *const)buffer + buffer_length;
>> +	u8 *const start_of_payload = (u8 *const)buffer;
> 
> I don't think the "u8 *const" is useful here, and the cast is awkward.
> If anything you'd want "const u8 *const" (which should make it not need
> the cast), but the const you have adds no value... do you even know what
> it means? ;-)
> 

My intent was to express that start and end pointers are fixed and will 
not change in the loop below. When reading this again I agree this hurts 
more than it helps, I'll drop it.

const u8 *buffer in the prototype illustrates that parse_control_message 
will not change the data so I'll keep it if there a re no objections.

>> +	struct NAB_header *nab_header;
> 
> surely checkpatch complained about CamelCase or so with the struct name
> like that?
> 

Double-checked, no warnings from checkpatch:
----------------------------------------------
$ scripts/checkpatch.pl --codespell --strict 
../../export/upstream/patch/v5-0009-wifi-cc33xx-Add-main.c.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#44:
new file mode 100644

WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: 
Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#5729: FILE: drivers/net/wireless/ti/cc33xx/main.c:5681:
+MODULE_LICENSE("GPL v2");

total: 0 errors, 2 warnings, 0 checks, 5687 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

../../export/upstream/patch/v5-0009-wifi-cc33xx-Add-main.c.patch has 
style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
$
----------------------------------------------

Obviously will fix the definition.


Still going over all other items you referred to, will take a minute :)

Thanks and regards,
Michael.


