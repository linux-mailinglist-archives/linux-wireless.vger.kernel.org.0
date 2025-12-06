Return-Path: <linux-wireless+bounces-29560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A96CAAB26
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 18:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2874630530BD
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571517993;
	Sat,  6 Dec 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMOORuJ1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWDfjQ+E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86B1E505
	for <linux-wireless@vger.kernel.org>; Sat,  6 Dec 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765042437; cv=none; b=aRee0emGEb4SjUMDkAofKEVlmIdmyuvfX7uGLMWEVIUxvmFDeN2FAnmCOVffJzXZHIRLe1XDemtfKOVa1PZvMHxHAZZ2J+3mImx3r1jDRWz2w3F2hTBzRvbHnwSXE/TtrWakV82ut9nwryoiybyRC4jN9f/oTVxEAS/Q7geqKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765042437; c=relaxed/simple;
	bh=4u6piWEW5GWp/yZRKMk2N6T2cZKf81vYOmPxFlwW6g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVbyKXzyfW7Y3Cj02jdl7BX1uUXnVa1gtklbi6TTXO4BjtQrEQjIGG3/pr8ulNJAhRakUFMhAKc1HWtDGNZfRDexMG8f2zV9LiVpE5W5ny75WOvV31m9eHVpS44eEFMLmp7U7YVCDTG4yFFYBrE0O3yqB0vIKGWed1MXdlyMDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMOORuJ1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWDfjQ+E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765042434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeNXpuNj3CLWoQ9rsjGUZ2lFiE+H0VgQvcQ4/tFNZwo=;
	b=OMOORuJ1qLHKh+ISZMAfsGeaIR78tF2gymzcw4jaShFSFNAo6Y0MMyYJzMfo5BXdP5kKYu
	lPyGIen+qyuxrz8wwAxitEj9MbwLX59NSTYgKUy+wk7w/5Tl2Mo9UOyQy/c9A6aFIkvx15
	cL5p5QAs4L5ucEdF5mfiedP8pgXPAOM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-eR2eGbMVPIiCdiZgxCdcaA-1; Sat, 06 Dec 2025 12:33:52 -0500
X-MC-Unique: eR2eGbMVPIiCdiZgxCdcaA-1
X-Mimecast-MFC-AGG-ID: eR2eGbMVPIiCdiZgxCdcaA_1765042432
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297fbfb4e53so56234065ad.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Dec 2025 09:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765042432; x=1765647232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeNXpuNj3CLWoQ9rsjGUZ2lFiE+H0VgQvcQ4/tFNZwo=;
        b=fWDfjQ+ElwiTk2xDebaut92axI47ZSaaFVyG15e3H+bX/yuwOo6yVZuJ0x55/Pa8ie
         zFgMLiGietmxoxeeJJ4PHLVc5ovxNB64gcM7DSls2tSU9BeB8Sroodq8LFsrv++TuXmL
         1TIaPtfemAvuJWQtHhE7KzcML9Djk47lcMutxKpDOqmiZEXa6Xxnm5PHXc3fSxO02kXj
         RGumBMi/A9pMsGS+49KYGm8y4QfBvSbcKeAaKvoMxFfr73ArnRkVuL+RHo96AUZ886Yq
         cBflbpRpAx59FNBeUmt8iF5eCMdmN4jk2WSADdsWulxply+JErrbwQtvW4C5wddd77su
         a1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765042432; x=1765647232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YeNXpuNj3CLWoQ9rsjGUZ2lFiE+H0VgQvcQ4/tFNZwo=;
        b=KFinq/JCJmfEZZ4VkEqajFoZ1z4Scl/SzJgG6plO0toaEG7yY/PJaW0MyAqVed4Wp6
         LYJznV/nj8Nh70yshGcC+JdkubiNpnJxteJhAkhdJem7BysxQ0HQpHxqp07lkD/8nryw
         3B1H8RmXnCYa7BkcMy30CKIo4ZiE43ps76i+Xkb/8ExqIDJ14Tjl2SnMPYtfNAbrAarq
         6SYspUsLUoisE7G2/+KHJTfX1OxXU9TCQPVvW2b3v6z0sULtUBI7hIF0xEyEBRLTPcPX
         RGBS7cIEJr9kfwNkva5pceCTkekkLxGdZeKHEPYTiyX37uV+qIQncwZWO06euRZEvkvy
         qeXA==
X-Forwarded-Encrypted: i=1; AJvYcCUUzUJns62arpg7mI5QGwIch3H6dzUNT8bHF7IE2T/R25Q9PH9BhKXjzLc3AeqwDuJ4Rl84YkdF1bagme1Z2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5Nhw8H+Kvi3zZ5T8grg3ioF5qtYNNC1NVYRNG0CqzYu1YMkW
	L+eou1RFqdi+lWiUYY4q8Htw98OhLm8f53YtNTUcr7bQPHqMM3ytAdDyq9R1w28FUz7fokCxCOD
	rTpAZoWz1fgRQhgUCZRuQ1ESdfi7PRgywGToTzxo1nZW1znhL/JnRQ2rdrkjVcKAXHfs=
X-Gm-Gg: ASbGncuPDl1e/xh16R0Cq+cka2KHhU4hFNgJhwbhFiTOM9lJVKt7TFNeUIy/SSH/x5T
	8uuQ4gEcmok8YKP3f9ftZtsUxLSjJKLRWArNpKpAInwc21EIRxfHx0LVIyhICujmREQJ0C3ABn9
	U2JN+SvE87IUA4BA3G8OCRFZLnxHOtYQoBL6dp1Vu19LtRU0AcuiqnBhbxbs5zCD4bLQUZlBCXH
	PgXXbhQ8mMQys3fT/TGV06m7CKyG+eK3FctqPWCWDGCfrEUl9qMSZUeMhxh8FXm19utejopNZlc
	fwhQZHMvfWx/lDu4DeH7GDTaTlHk10tfmG2C4y+exaXxGsstLv79v+dzgmi/m1xspqEs1h82wZZ
	RYiz6hHCNd3AyDQYioPaklYbmnYXygVw+y83r7w==
X-Received: by 2002:a17:903:1a03:b0:297:c048:fb60 with SMTP id d9443c01a7336-29df5abde27mr23041205ad.25.1765042431816;
        Sat, 06 Dec 2025 09:33:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6H77H+WKzaFxWOn0tQaG5AQoCoetYQpE/SOW+Hl1DrsGMxlKrG3SFuf1jY18sL5vpRHxppw==
X-Received: by 2002:a17:903:1a03:b0:297:c048:fb60 with SMTP id d9443c01a7336-29df5abde27mr23041075ad.25.1765042431452;
        Sat, 06 Dec 2025 09:33:51 -0800 (PST)
Received: from dkarn-thinkpadp16vgen1.punetw6.csb ([2402:e280:3e0d:a45:3861:8b7f:6ae1:6229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaab1d6sm81026605ad.67.2025.12.06.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 09:33:50 -0800 (PST)
From: Deepakkumar Karn <dkarn@redhat.com>
To: johannes@sipsolutions.net
Cc: dkarn@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	shaul.triebitz@intel.com,
	syzbot+5bb5f06f99924ea0cf86@syzkaller.appspotmail.com
Subject: Re: [PATCH] mac80211_hwsim: fix divide error in mac80211_hwsim_link_info_changed
Date: Sat,  6 Dec 2025 23:03:45 +0530
Message-ID: <20251206173345.356068-1-dkarn@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <6cc422bb9525be529c6b0d2d25f9869ca41ec77d.camel@sipsolutions.net>
References: <6cc422bb9525be529c6b0d2d25f9869ca41ec77d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Sat, 2025-12-06 at 04:33 +0530, Deepakkumar Karn wrote:
> > On Fri, 05 Dec 2025 18:39:49 +0100, Johannes Berg wrote:
> > > Seems like we should not let userspace do that, to protect all other
> > > drivers too, not just hwsim.
> >  
> > As suggested, we should provide a zero-value division check for other 
> > drivers as well. I will investigate other places where divide errors can 
> > occur due to edge cases.

> What, no no.

> > Please let me know if you meant something different. In the meantime,
> > I will analyze other drivers for similar cases.

> I did. My point is we shouldn't _have_ to check any drivers for this at
> all, it's nonsense and higher layers (here cfg80211) should reject it.

Thank you for your response Johannes. cfg80211 already have validation 
in cfg80211_validate_beacon_int(). The problem seems to occur in 
case of interface shutdown which calls ieee80211_do_stop() that makes 
beacon_int = 0 or set_tsf which causes divides by zero.

What if we:
1. Handle off-channel operation:

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index ae82533e3c02..14a103d320e3 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -156,10 +156,12 @@ void ieee80211_offchannel_return(struct ieee80211_local *local)
 
                if (test_and_clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED,
                                       &sdata->state)) {
-                       sdata->vif.bss_conf.enable_beacon = true;
-                       ieee80211_link_info_change_notify(
-                               sdata, &sdata->deflink,
-                               BSS_CHANGED_BEACON_ENABLED);
+                       if (sdata->vif.bss_conf.beacon_int) {
+                               sdata->vif.bss_conf.enable_beacon = true;
+                               ieee80211_link_info_change_notify(
+                                       sdata, &sdata->deflink,
+                                       BSS_CHANGED_BEACON_ENABLED);
+                       }
                }
        }

2. Handle case where debugfs is written after shutdown or any race condition during disable beaconing:

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 551f5eb4e747..8363cdd17a97 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1242,7 +1242,7 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
        struct ieee80211_bss_conf *conf;
 
        conf = link_conf_dereference_protected(vif, data->link_data[0].link_id);
-       if (conf && !conf->enable_beacon)
+       if ((conf && !conf->enable_beacon) || !bcn_int)
                return;
 
        /* adjust after beaconing with new timestamp at old TBTT */

3. As other drivers already have beacon_int 0 value validation, consider 
   earlier patch along with above 2 points?


