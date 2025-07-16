Return-Path: <linux-wireless+bounces-25509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A1B06D3A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 07:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1461C20121
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 05:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B374B2E6D11;
	Wed, 16 Jul 2025 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Nh+5paTr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF72E6D02
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 05:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644007; cv=none; b=Aoim/7O0ODywZVtdFNvP2nkKkvAlUvwFLipWPIRpc8BHQ0MKzR+Wd7IVChOoB80uwpBrDTu4ZPb2Yki7mObZjbY0bGx4sgDvWDO+CAKWWdPgl4nBh4t03bURYMFbx4gxheI+f0jnldWxA3iffRpFc8naHpfMJ44Dbbd0iJ2DXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644007; c=relaxed/simple;
	bh=ulKcL97ipqI66R3ISVFVZkVnrLVclUH/0NTZzyPaE9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2zBTquOz9uGaIeI/D4V5MukUBgc1QBACJpWskKzAdRj61ejpC3qgYUzi2Ix54Khk3YRS2AYzXDny1rEUVjgUfIijbJ90A5DQURppVk03t1eZ7Hnvet1w2M93zUdmdci0hHWcjNVmiC0ptGGJcxcT6xdxiwFXYV/jksy9rZz5lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Nh+5paTr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so5007677a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 22:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752644005; x=1753248805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKYJXAwAjKFW4dGonImlaj8Ujch3wxOgs+1LnQOo9zs=;
        b=Nh+5paTr1OMqV9ILOeeO7e9dx7ghIqzdDsEfRB1pSM65xiuqSTILrVZ/XxzcNHebl+
         roh//d+aknAtPtd1XsVMQwkub9XdfEwfl9FPANBKytrmF1IW5jqsTVUT5AjSpL9JYnKR
         0P0Nj/l1RQdu1N2fe/VrGcbuRGfPKeeWn0nh1DecYFCf0X37odogWAeoUFF80NH5EIY/
         Q/gAUS2loee4HbSdbjAp/u0lEF0Mxq099dEJYkW7LMvOYooD3HibP+uvtx3D1ymdBAUZ
         3WwDnDlWUo6QUKv5Z96ERPg8m1Hp+h4+AI4g/8+GX6P1p06x3Ds5IotMwPqaZXGkq86f
         ADDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752644005; x=1753248805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKYJXAwAjKFW4dGonImlaj8Ujch3wxOgs+1LnQOo9zs=;
        b=uDOfyvHYXyaTTu1CM69PLEJPOaDMiswqqf2Gz1Yai/MuPIwwIx8kJBFPahgzSX+kBZ
         s3R0CxtePtSdeX0widef3mFkaaI0Er+rG0oW1Pq1XaP/A9uD4d8yq/twD49Cjczo+NuI
         hQ41R8btUVYXSDnItUK5rFqeF7FhcWvVMSBAZp0j2hlNGbOGF4a2SgF5PoLxO8LhK1P5
         j13tXvLsRPqt/kE/27Bs1FwLNKRdm5h399WUigmh6/Y+rIJoj/cQ/kTjTna9c0AYtpoI
         w7TZvqixNBePWqQ4MATHAYQUosNs+rcIip1dExNJr6j69GZ9n+lhB/LniJmdPbQrfMr5
         A2BA==
X-Gm-Message-State: AOJu0YzEizyjuglmyeU72QQ7+hyqLyvFNcI9n59wL8CsSrDTecK2lVlS
	bFgqTaAokppDeXuHASz0ReOq8bw1ZYM8MqetZf2TPaJUmn1WrUM5xDX5U40z7GMcg1k=
X-Gm-Gg: ASbGnct4uk3TKYnYLDvpw1UVr1nZtgQAhGKmWDLoOpo9KayVQDy7I3t4Sf1wrjLmSBA
	Ecsky/PqD8evFQcSlJajJ8HBIPTiUyluImNRjME3bt0KSa4tl0/Y29frK6J3MWKO/y2J5NsV+CL
	/eF5mJmSO13b4hl725SJTHLNVAxjd7wNblXDRgFqoIOwcj+OwwLmti0C0bDev4Ol6COI49tZ6+V
	uSYax5NVbrWhLLz+cLoC8EAGpJSLOZd1NAyNOr8IEcRCvkTnG204y1yDSDICx6SpwH5yUJhGfjy
	nevF7xlueHDD35+rqmsN3OmSuZWX+Z3frpzt0M+T2JclPY6BMOL1NyN5T7uDWur+WR45C8QZcFo
	9u+Ehb82GRkrZzfZjnWoMeJlfWTeZoI+YL3VsJYQ=
X-Google-Smtp-Source: AGHT+IHwZ9a0CodGDuhqCony9M93DovvnSuPLJgbH1nnfACNgS/PvYXP+fUYb4jioyYw+FZEtp3U7A==
X-Received: by 2002:a17:90b:180b:b0:315:9ac2:8700 with SMTP id 98e67ed59e1d1-31c9f44606emr2145690a91.24.1752644005007;
        Tue, 15 Jul 2025 22:33:25 -0700 (PDT)
Received: from mma-H9MHD44.lan ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1ba792sm580382a91.5.2025.07.15.22.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 22:33:24 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v2 0/4] [v2] wifi: S1G short beacon support
Date: Wed, 16 Jul 2025 15:32:50 +1000
Message-ID: <20250716053254.439698-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset implements S1G short beaconing within mac80211 and
cfg80211. I don't think its worth going into the technical detail
again as that can be found in the commit messages or in v1:

https://patchwork.kernel.org/project/linux-wireless/cover/20250714051403.597090-1-lachlan.hodges@morsemicro.com/

The changes since v1 are as follows:

(1) Rather than introduce new validation routines for the short
    beacons, we leverage the existing routines since they can
    handle all beacon formats and ensure both long and short
    beacons are well formed without validating the existence of
    particular elements.

(2) The long beacon period (renamed from short beacon period to
    better describe what it actually is i.e the number of beacon
    intervals between each long beacon) is now an individual
    attribute. The reasoning behind this is that this attribute
    cannot be updated dynamically, unlike the beacon template. So
    we have taken inspiration for how the regular beacon interval,
    DTIM period etc. are handled. This allows us to use the same
    routine for both updating and setting the beacon data, but
    require this attribute when bringing up the interface if it
    is to be using short beacons. We think this is a much cleaner
    approach.

NB: It was mentioned it would be good to find a better way (or
    introduce) a new method for determining if we are bringing up
    an S1G interface. This patch does not handle that, though it is
    something I briefly looked into and will probably be done in a
    future patchset.

(3) We no longer introduce the short beacon variant for the beacon
    interval or DTIM period - and instead just reuse the existing
    parameters since - fundamentally - they don't change anything
    besides add more code complexity to various key code paths plus
    require changes within mac80211_hwsim. This patch now no longer
    requires hwsim changes.

(4) Drop further validation from within mac80211, and just perform
    it within cfg80211.

(5) Due to (3), we can drop all mac80211_hwsim changes.

(6) Fix up a kernel-doc error and properly describe the max
    short beacon nested attributes.

Overall this patch is much leaner, and has less of an affect on
non S1G interfaces so that is obviously preferable for everyone.
Even then it is more inline with what is currently done when setting
vs updating an interface and handling optional attributes.

I've sent this as a non-RFC as I think it's a "finished patchset"
but obviously still open to any feedback to resend another version.

Lachlan Hodges (4):
  wifi: cfg80211: support configuring an S1G short beaconing BSS
  wifi: mac80211: support initialising an S1G short beaconing BSS
  wifi: mac80211: support initialising current short beacon index
  wifi: mac80211: support returning the S1G short beacon skb

 include/net/cfg80211.h        |  23 ++++++++
 include/net/mac80211.h        |   9 +++
 include/uapi/linux/nl80211.h  |  39 +++++++++++++
 net/mac80211/cfg.c            |  93 +++++++++++++++++++++++++++++-
 net/mac80211/debugfs_netdev.c |   2 +-
 net/mac80211/ieee80211_i.h    |  15 ++++-
 net/mac80211/mesh.c           |   2 +-
 net/mac80211/tx.c             | 104 ++++++++++++++++++++++++++++++----
 net/mac80211/util.c           |  31 +++++++++-
 net/wireless/nl80211.c        |  72 +++++++++++++++++++++++
 10 files changed, 370 insertions(+), 20 deletions(-)

-- 
2.43.0


