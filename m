Return-Path: <linux-wireless+bounces-33909-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOCYCjKOxGkh0gQAu9opvQ
	(envelope-from <linux-wireless+bounces-33909-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 02:38:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAEC32DF7A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 02:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F05E302C5D1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 01:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A1A2459EA;
	Thu, 26 Mar 2026 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPzxCEBd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7FF4F1
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489056; cv=none; b=cgFTy6GYKmGoDcDLscoT5gxEqG39y20VFEL6VJ4/ShuEdPwL8owRNKRdtAgXPa595siIEDk2h0KDZabvmr9JEaRiOfZArxZnCpMNv+mHoNC17UZxFxkigf+grtAxqr+mrujKo5qVOpizrNvMdmM9MuyKolm9ki5elnuuLGy+7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489056; c=relaxed/simple;
	bh=Jj2qm8qG63CrbIFMV9IlMuOzVORLnHETDXVgtmwwQxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvBMkzRloJen+zSKAOSwQKCi/zsfVD5fRxpZa6v/4inZKY6ENyX8ZIf70fJ5VSMJM7fwJQjHPxbbx7CI2VPw153ahuNKjUO/SoXxUy5bQzTHgauuBsRn3A6N5uxxONAah1CdeyBQbztsFdZ0tKzeaNqo8OvA0onNSNEKeB7Y6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPzxCEBd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a646c96bdso362404b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 18:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774489055; x=1775093855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAPOHm+2rdklVBQSpRSKOLEhOKAWiuPin4IyJcaEptM=;
        b=lPzxCEBdmqkipI9rRiylIAI9Pm8f+9DbddUXdmriv4csOgioReWznr1cTmg8xKFm4g
         bH+kF1HTdylg2fbDUzuFYv4TC8BHxa9i3vxTOGoHOtPy+//jycwQ05UiEuGehqqHQ1Qc
         E4BO1TJblnfZJbUiSrw8YukQXisZUv6jCtdSjow5iV5sHoHnrxDPWdk4SkefTEm34lpg
         o5C+Roc981IZboV+bQzjCBmVyFh2UcJ9XIBKLF07nfgPlGZ7xnbS7pdthZa0ZpMffd3A
         /PMx50RQx+EIihthMivVSrx+l0EtH5xh0+eGnbH1BNGY/LjQewPOeIuoOemdwD2tsgMb
         irgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774489055; x=1775093855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAPOHm+2rdklVBQSpRSKOLEhOKAWiuPin4IyJcaEptM=;
        b=VMnoeuwLMzwKdyGbGF3O9FM1WGZxq+0QVeE4XhdFWl1vHVFJZ+BxdTs8WgfbDcgCXG
         htli2eCmNf92fhtTxsdgrAzXKr5fapkYxQyh5v+KMmWXy7bi8Z3cCc/uR137+JFRO+Lg
         1lYS42v6jHVCXzrdJs7D4E+Bqlse50SqHOCa1yIJnA5jMl7JHp4QOgZ9Aq8vXDlyv80B
         yB7Rys1EljxKv8vfp3m8YD7dGb1H8haiypPNMY2EMeb7y5aGi98/jeuQAnpO9pdtfWFB
         qDjdKZgk0ia3iNewB9j2j2hwwmSwsMlHz8YmLN3pJb9ht2Bsg7AKUrXRCX5IPJ09fkdf
         FL0w==
X-Forwarded-Encrypted: i=1; AJvYcCXSw0YtCVjoHHbcJOPiKJmMmokClJGjPJHT/UuHsWJfdHsijkkx1Ny99tBXw3QIKJH43w0jBjC37j9necjoLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOoyw1YELt2Ix+wKWDVGpPk7jnEqV8wNwHagmCqRmOmJa86zo
	vK5BcVr6pe1VKsz7Hhc7KkTucbymiA2g17/+e6rl9itc2Ci4n65MPFDc
X-Gm-Gg: ATEYQzz6rZelfEX5V65JYPAjNux2J7/jdz87cLTwPTcdq3KSwjhhdhOhLwS9B4PCjiH
	0XPPQv9GtpWdKnbwRP+fbvf2iJxHqREnMpw192icePoCsAYPbQj6Pbsm1Zl6P+jxiTHfy9sH9Wu
	zo8YgZ3/IAnxR4PjRabKv3kG8FLm+YGxsJL1HF5wJG0IDiWQK3EWToZDnMgRIT8F8N3AD493uUc
	6kVEc/7Xh63/h3ngrLuTawd85MJzJoc+v3O5mBKVS/gxKR0ZDUsjoVPdkePx3C1EKdS6zYs+iaA
	PrCB8KGR5tiP/oLv0xKAJcXGOUaqeJgxRTOi9yf982CSATNdPcFdlWl1imds/xk3Aaj6vtrUYr8
	BohGl9tNEls8pCPKoriTHW5ZYrhqer7Fiktmdg5Z48f6tQonyw+fljfk9thAXizKcPI3kinRl/1
	7cPcj0lcbYeekuOdTIy41HhoLR+3Lm6UnP455w5+HZ1z09jYvMIS09NHXAI9599z8roP/d6bXgK
	He/
X-Received: by 2002:a05:6a00:2ea4:b0:82a:6e7f:4c14 with SMTP id d2e1a72fcca58-82c6df6609emr5412590b3a.27.1774489054556;
        Wed, 25 Mar 2026 18:37:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:820:e910:540f:de1e:bee1:7630])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d400f62sm883251b3a.55.2026.03.25.18.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 18:37:34 -0700 (PDT)
From: =?UTF-8?q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
To: oscar.alfonso.diaz@gmail.com
Cc: fjhhz1997@gmail.com,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mac80211: fix the issue of NULL pointer access when deleting the virtual interface
Date: Thu, 26 Mar 2026 09:37:19 +0800
Message-ID: <20260326013719.1662-1-fjhhz1997@gmail.com>
X-Mailer: git-send-email 2.45.0.windows.1
In-Reply-To: <CA+bbHrW0Z6NdFsUwycvRhLbe3xnbXSwmb24EW4FKFtn=0TVzBw@mail.gmail.com>
References: <CA+bbHrW0Z6NdFsUwycvRhLbe3xnbXSwmb24EW4FKFtn=0TVzBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33909-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fjhhz1997@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EAEC32DF7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Óscar,

Lucid-Duck spent some time trying to reproduce your crash and wasn't able
to trigger it. Here's a summary of what was tested:

- Kali 2025.4 (kernel 6.18.12+kali-amd64) VM on QEMU/KVM, with my v2
  patch applied
- MT7921AU USB adapter, passthrough to VM
- Full airgeddon evil twin flow: monitor VIF + hostapd AP + continuous
  deauth via aireplay-ng
- Also tested on bare metal Fedora 6.19.8 with the same adapter

All tests were stable -- no crash, no dmesg errors, load stayed low. The
deauth frames were confirmed sending for 30+ seconds under the v2 patch
without issues.

The one variable that couldn't be matched was the VM hypervisor.
Lucid-Duck used QEMU/KVM, which handles USB passthrough at the kernel
level (xHCI). If you're using VirtualBox or VMware, the USB passthrough
path is quite different (userspace proxy), and that could potentially
explain a total VM freeze that isn't a kernel panic.

Could you please reply to Lucid-Duck directly on GitHub with the
following information? Here's the link:
https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-4129198757

1. Which hypervisor are you using? (VirtualBox, VMware, QEMU/KVM, etc.)
2. Your exact USB adapter model and ID? (0e8d:7961 covers several
   MT7921 variants)
3. If possible, try SSHing into the VM from the host while the display
   is frozen -- if SSH still works, the issue is at the hypervisor/display
   level, not the kernel.

Thanks,
傅继晗

