Return-Path: <linux-wireless+bounces-3489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49268852263
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 00:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0184B2842FF
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 23:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88F650249;
	Mon, 12 Feb 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="nXY8Ufpb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939E50246
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780200; cv=none; b=n5QoiVO2MSB1FHVthqhwzHh1IoHu4gspQQ1bwIjCT1BwcY8bcJPERMAcLGGDLxkiI4Bxk380gPjzH3jfXJq2aa09NCNkfpF4T6EOXVHNGYsnIkqBnkM9YEIqjLUqscZBzICxh6c0NVt61bT9kzq1zRWdXtwYoWbMP/j4oNYoDM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780200; c=relaxed/simple;
	bh=Kz4tnQUBzn82pcvZ87l4OwR2Sv1VAHKshb7vp+idMs0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VBTVyQ4w0k0v4ONz9gAJMSYONzN0L8BfkaKhJwt2ATZfisdToXVtwCFHy2nFtvUcINobuSQYJ4JCRNya0R/UyPIUIGga0EI3VEJ+oBD1R3kMXRPsxJS142lIptEx4GIyFAdst5TVMINqztPLIVeTJpTUfEiI8QISMTfPGvixs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=nXY8Ufpb; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C12785028CC
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 23:23:12 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9BC1580083
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 23:23:04 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4527F13C2B0
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 15:23:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4527F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1707780180;
	bh=Kz4tnQUBzn82pcvZ87l4OwR2Sv1VAHKshb7vp+idMs0=;
	h=Date:To:From:Subject:From;
	b=nXY8UfpbIANLqfg56rAsv8aw914SwfdWA6x048SQdUBseA3O+DVbR9J/5s6UcpX5E
	 FPooDlNcVCyLQUiIVOqBzGCxSi+LiTI1jEgsuD2IK4XvgCZkRtO+gpnrPYWmqlKgND
	 L9EIZIEt2a/cZN93LXEZHNYO7r1x7+1vYzK2LIKQ=
Message-ID: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
Date: Mon, 12 Feb 2024 15:22:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: iwlwifi RFC related to iwl_mvm_tx_reclaim
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1707780185-mh2kWgLMyUEm
X-MDID-O:
 us5;at1;1707780185;mh2kWgLMyUEm;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

Hello,

I'm seeing a crash due to accessing an 'sta' object in this method that is '-2' as integer.

It fails the initial check for null STA, but I'm thinking it might should check for IS_ERR(sta)
as well.

(I have my own patch that references sta before the IS_ERR check later in the code, and this
causes the crash I'm seeing.  I guess upstream will not crash in this situation.).

My question:  Is the patch below a preferred approach, or should I add special checks to where I
access sta and only exit the method lower where it already has the IS_ERR(sta) check?

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 0567f4eefebc..bd3d2fe424cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -2337,7 +2337,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
         sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);

         /* Reclaiming frames for a station that has been deleted ? */
-       if (WARN_ON_ONCE(!sta)) {
+       if (IS_ERR(sta) || !sta) {
                 rcu_read_unlock();
                 return;
         }

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


