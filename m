Return-Path: <linux-wireless+bounces-32362-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAGHJn4dpmmeKQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32362-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 00:30:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F15F31E6AA8
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 00:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97416309888C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 23:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D320C31E835;
	Mon,  2 Mar 2026 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="aWQg6R9w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924201A682F
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492814; cv=none; b=Tb1u/xIZWoU8IYL3cNlOa+Rbe8F9w51KoaMfNJtnXBXIJri9idtg7tKsxDb/7fVrezCgMyAfVt95Q1HRG8GoyyecQ7EIEJv0ARZxI9MaYrAmKBwx9EAcclkC+8hr8OSd8ZXGLfO5kRA0QajsxZtOi2AbT1e1U5TbDeGznAzXewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492814; c=relaxed/simple;
	bh=HuAqiHYHvK83n+tTuaQOBwY7cZHeyIYx1dttPGtdvPY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pWPytkzM5Q2oJ0BOwUXRZBYekdwSQq4Do/e+unFX/eNsW0DpN1h0rH/y7uQZD3iVYMVkw5ktKzsxGbIaxaNjEEQZCr8W/dcgVpOdcwm7/ZC5V+qYP0TedBNaV5egYMImlIe0ZkaKzrJCi9XcnSgzMSfCHzTqPHWIP6xmx7cZYn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=aWQg6R9w; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8900B8C0073;
	Mon,  2 Mar 2026 23:06:51 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E1FCF13C2B0;
	Mon,  2 Mar 2026 15:06:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E1FCF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772492809;
	bh=HuAqiHYHvK83n+tTuaQOBwY7cZHeyIYx1dttPGtdvPY=;
	h=Date:To:From:Subject:From;
	b=aWQg6R9w4Y9uL9eCbq7nAyy/2rebVKCYFmDafZN+SlOrOwm0ApsXummvHe8OYYd57
	 IaYQHMVefOYsL4fISfzmbaL9eO+H7GKBQ0CGlupxoGFGNJrUGlYMvWkeji8ToG3KJg
	 zziMPQjAAjRXAI/inQVnGOKJ7ccvknYNKmq1gLrw=
Message-ID: <02f66cee-4892-24a3-9a07-1e722fe8888f@candelatech.com>
Date: Mon, 2 Mar 2026 15:06:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
From: Ben Greear <greearb@candelatech.com>
Subject: iwlwifi-mld: Fix fw id leak in OOM case
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772492812-OAXVCou9GPzn
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1772492812;OAXVCou9GPzn;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: F15F31E6AA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32362-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello Miriam,

I believe you will want to add something like this to your driver to clear the
fw_id_to_link_sta ID in case you hit the ENOMEM case.

I have no reason to believe I am actually hitting this error case, but I saw
this questionable code while looking for reasons for the use-after-free I am hitting.

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 5fb2a46241e4..de9939ad1d58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -535,13 +535,19 @@ iwl_mld_add_link_sta(struct iwl_mld *mld, struct ieee80211_link_sta *link_sta)
         ret = iwl_mld_allocate_link_sta_fw_id(mld, &fw_id, link_sta);
         if (ret)
                 return ret;

         if (link_sta == &link_sta->sta->deflink) {
                 mld_link_sta = &mld_sta->deflink;
         } else {
                 mld_link_sta = kzalloc(sizeof(*mld_link_sta), GFP_KERNEL);
-               if (!mld_link_sta)
+               if (!mld_link_sta) {
+                       IWL_ERR(mld, "mld-add-link-sta, OOM, clearing fw_id_to_link_sta[%d]\n",
+                               fw_id);
+                       RCU_INIT_POINTER(mld->fw_id_to_link_sta[fw_id], NULL);
                         return -ENOMEM;
+               }
         }

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


