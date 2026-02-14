Return-Path: <linux-wireless+bounces-31833-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDrvLsWtkGmscAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31833-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 18:15:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B1113C94E
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDBFC30120FE
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DAB2853F8;
	Sat, 14 Feb 2026 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="NnbObArz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDEB1397
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771089346; cv=none; b=S7w3p5qvDiny0IODyjOzUc0tF+4Ai/KaASR8dTFs2CFLQ0RQWSRxyrvQCgC0y9dr5SzBL+aqXAI6mgUsHGf+Vmd/Y4nSv8xgzSf2Rount45/vkTGfHoFo93eGNvrj0YyYYIFDCJzHVjanxs2O4ZDElxjq7mI97xO9TTryodE7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771089346; c=relaxed/simple;
	bh=NN8j+fdekKBY/tAQCLNDtUkvu0cziDzhXviKo55Z9Z0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iPb231TykEBoAKNeXpb5xgLk0meuCbJWjRWQXyos8tGNZ7r9su39S8ctY2mSzdQAKiasKadiEC0C7W4YXD7zKFSCaLiIGEEEp4hIHcyVJOg2JtIuYvFT0AJQBF4e3kDCxMaXQtRXwRpiuiz5eXpqs7x8DQ5ESMA5/f1Bwu8zhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=NnbObArz; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ACD2450A4F5
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 17:15:44 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0A458800081;
	Sat, 14 Feb 2026 17:15:36 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.32.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id B116913C2B0;
	Sat, 14 Feb 2026 09:15:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B116913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1771089334;
	bh=NN8j+fdekKBY/tAQCLNDtUkvu0cziDzhXviKo55Z9Z0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=NnbObArzWGVY77qRgxpywZ2Bg0iFq3JgBCiESyccI7/zl3b8BTTa6kLJBq4uROlhz
	 6M24AFdrM30img3npHR7UjJ3UMR9NYmlnDwj7G8hV8CFQZXyxJHSk6i0Fuo64ptl9R
	 a/mDO0nLs7/NgD7H/y8AwheReJTo7zTb1yc+GYQg=
Message-ID: <1cf6d7aa-7ced-4fba-88e1-adb1cfdecadf@candelatech.com>
Date: Sat, 14 Feb 2026 09:15:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwlmld iwl_mld_change_vif_links can return un-initilized 'err'
From: Ben Greear <greearb@candelatech.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
References: <5ffe48af-e02d-4d02-b669-6a9d6797b956@candelatech.com>
Content-Language: en-MW
Organization: Candela Technologies
In-Reply-To: <5ffe48af-e02d-4d02-b669-6a9d6797b956@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1771089337-8kZdHK31rUIC
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1771089337;8kZdHK31rUIC;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31833-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,candelatech.com:mid,candelatech.com:dkim,candelatech.com:url,candelatech.com:email]
X-Rspamd-Queue-Id: 35B1113C94E
X-Rspamd-Action: no action

On 2/14/26 09:11, Ben Greear wrote:
> Hello,
> 
> I believe this method:
> 
> static int
> iwl_mld_change_vif_links(struct ieee80211_hw *hw,
> 
> Can return un-initialized 'err' in case that this return path is taken:
> 
>      if (WARN_ON(!iwl_mld_error_before_recovery(mld)))
>          return err;
> 
> I saw this warning hit, and then later kernel crashed with some debugfs
> dentry being bogus, but not sure that is actually related.
> 
> Probably err should be initialized to -EINVAL at top of the method.
> 
> Thanks,
> Ben
> 

I guess in case that error path is interesting, looks like FW stopped
communicating and that is probably what caused the warning:

Likely at least some of this logging is from our own patches, FYI.

[  159.220486] wlan17: ieee80211_vif_set_links: new_links=0x4; dormant_links=0x0
[  159.220511] iwlwifi 0000:25:00.0: Failed to send flush command (-5)
[  159.222763] wlan17: associated
[  159.224559] wlan18: RX AssocResp from 8a:88:81:84:d9:81 (capab=0x1511 status=0 aid=192)
[  159.224563] wlan18: ieee80211_vif_set_links: new_links=0x4; dormant_links=0x0
[  159.224565] wlan18: [link 2] local address 82:fa:ed:e5:1d:de, AP link address 8e:88:a1:84:d9:81 (assoc)
[  159.224576] wlan18: ieee80211_vif_set_links: new_links=0x4; dormant_links=0x0
[  159.225503] iwlwifi 0000:25:00.0: Failed to remove station. Id=1
[  159.226598] wlan18: associated
[  159.230293] iwlwifi 0000:25:00.0: Failed to send LINK_CONFIG_CMD (action:2): -5
[  159.236374] iwlwifi 0000:25:00.0: Failed to send PHY_CONTEXT_CMD ret = -5
[  159.241885] wlan2: ieee80211_vif_set_links: new_links=0x0; dormant_links=0x0
[  159.254418] iwlwifi 0000:25:00.0: Failed to send LINK_CONFIG_CMD (action:3): -5
[  159.260503] iwlwifi 0000:25:00.0: Failed to send LINK_CONFIG_CMD (action:1): -5


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


