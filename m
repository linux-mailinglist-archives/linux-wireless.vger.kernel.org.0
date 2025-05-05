Return-Path: <linux-wireless+bounces-22428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E74DAA8B56
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 05:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA4F7A22C8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 03:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C614B96E;
	Mon,  5 May 2025 03:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UffyoQE/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1874C6E
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 03:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746417050; cv=none; b=vE+xdt++YWrVZwe/2aZxMt7/jt9oAwWkjpWG59xzHeYUBrl6cT8sbHL36IVsnbEmMdEBlMmb5gaCsOdPfxbxTGXeePfs32XxXXeWC0E5wotKnOg0eGNs0MO0FZTx0cEuQCMqPrr7gfiqh0mvOHEsIJLTxr0D0BTDF6tfGVb4dD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746417050; c=relaxed/simple;
	bh=vYtITgka0WCExMfmhJHg25zGVrIXvPdee1YNAZYSMF8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LCe2pCUkKk71sITqUKT+DDyrdH7+i80YNrHTPjQU8soIYxA2G/Ad5hIszrhxVXfGRcVGyOAs5pp5l89CZaCL54L8Qyr3nnDkQvD7mBrLY++qd8Dv+raA/VuN12SeEcWUgg/uYPzqDdwvI1y6PWbVdUAebfGw5KlkdHSnWj352Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UffyoQE/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so6070312a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 20:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746417046; x=1747021846; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PUjcMptLSLyFRZE/3kaPRNeIAkij7+eKxbc+D4z0Ci0=;
        b=UffyoQE/nv72uzbojX0cjw1jJTaCelX2N1dPLlsC40b2m6l612f+GBeQPxN2ZD63/v
         ianZH68C3Ub1CAp256ML2vu/9axpSi+7R4LHze8U6Suzn6cxz3PXAY6TrkMbwd70ipJ0
         zHrr5usMbu1Iy9nOmEszxsh2uL2BPQHYv3XvJhJIsmElgBZZxNi1MczI4cfAErFM3LJx
         e/PeZQSl4PjJRc7xUXAVy48cKS6bx3VpZnJmSLHXAAfP45PLLKMJEdr8YpvlE69KrD7H
         o3P6JFl/bdyi423UTnSi0FpXHZlGHY8EQ1sLlYvOoE1vNCGdp+bHA+3yXKeqFk2Lq4lj
         +teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746417046; x=1747021846;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUjcMptLSLyFRZE/3kaPRNeIAkij7+eKxbc+D4z0Ci0=;
        b=SiAVoaO3GnHF4rY6YjVGSlsoD6cyWVe0lFTgJJkBJVe0RkJsXXH6KfoisY4s6Im/dW
         aLkkhfacI9F9GpXHASlNnfmemxYZfRAu9Ff2Od9GDCrz7S/ItypMlFn9vsb975aFad6B
         +HWOeACmd/JntLIuGKTRKo+1oE2Ac2hqWy792ADTee6QdRn/mg5SuK/c+xln8vQlOAE8
         nti0Y8fW/or3TiVW3cxw55AbJOUFwngKdxBYZ2T2ZtX3rT1dX9CV6A2GdDEf5wY1Ebkr
         t8KknK+Vi1owiuw3merDMEIkqNrdGaebpzmWAZoHIzKP+N0TUbWtk6vAw3AJuSj0UqL/
         rfrQ==
X-Gm-Message-State: AOJu0YxfBovL86Z7qMJFLjiHYkneu43lhU0lh+QXynCkBgjqO0oNKJbT
	osY1/hsA3/mO3DpPFicJVKFOAux3OC8qz4CZ9Qfg8G43R9mDo4w00HmoRtun2+ONZYhunD6EDs+
	qs6hlE93oFPj8m1rSXqO8DID5Dvb1cg1c
X-Gm-Gg: ASbGnctta+SNI5HGEtUgXrJooUpZorH4Gw18ChYTFmhHen3UOwz+tuvkSt/q7iogEtP
	uaAveVyR4IhcW+SralfEltYhnfyLGnm048RW8FLAdlqSlP4g+QO4ypUkCILJKQaQCa/a32hn9VG
	KHe3LsTNujbPHM9wwgX+r3O9Hk52wquUN9dy/+3uJ/9xQ2drsMZVOeow==
X-Google-Smtp-Source: AGHT+IHxqJ2/Nm+9QA0Hb5syBlXBxaZ/0O2z2/CCQiaiQDv2IANW4DbRz3aOyo2ii+nDFz9DXB2RR3PGcR7p1iwIQbQ=
X-Received: by 2002:a05:6402:27d0:b0:5e5:bb58:d6bd with SMTP id
 4fb4d7f45d1cf-5fa7802f96fmr10473012a12.10.1746417046389; Sun, 04 May 2025
 20:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Samuel Reyes <zohrlaffz@gmail.com>
Date: Sun, 4 May 2025 21:50:29 -0600
X-Gm-Features: ATxdqUHbje6j_1Sp1WMsGpIkTkDOV6DEJbFCl5wPo75I4hXQgawE-2F-xNEGPOQ
Message-ID: <CAD+XiyEJo0m8L6PbmBD=NPPa0E_wX3kk4ezn1qZ0d8JGXsS1qQ@mail.gmail.com>
Subject: RTL8922AE driver issues
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

My WiFi has intermittent connection issues on Arch. My motherboard is
a Gigabyte X870 AORUS ELITE WIFI7.

Even when installing Arch my connection was unstable, dmesg -T is
littered with entries like this:
rtw89_8922ae 0000:07:00.0: failed to update 162 RXBD info: -11
rtw89_8922ae 0000:07:00.0: failed to update 163 RXBD info: -11
rtw89_8922ae 0000:07:00.0: failed to update 32 RXBD info: -11
rtw89_8922ae 0000:07:00.0: failed to release TX skbs

I have not found any information online for this.

I've added this as a file to my /etc/modprobe.d/ folder but it hasn't helped:
options rtw89_pci disable_aspm_l1=y disable_aspm_l1ss=y
options rtw89_core disable_ps_mode=y

Here's my lspci -nnk entry:
Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8922AE
802.11be PCIe Wireless Network Adapter [10ec:8922] (rev 01)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL8922AE 802.11be
PCIe Wireless Network Adapter [10ec:8922]
        Kernel driver in use: rtw89_8922ae
        Kernel modules: rtw89_8922ae

lsmod | grep rtw:
smod |grep rtw
rtw89_8922ae           12288  0
rtw89_8922a            73728  1 rtw89_8922ae
rtw89_pci             118784  1 rtw89_8922ae
rtw89_core           1130496  2 rtw89_8922a,rtw89_pci
mac80211             1757184  2 rtw89_core,rtw89_pci
cfg80211             1441792  3 rtw89_core,rtw89_8922a,mac80211
rfkill                 40960  8 rtw89_core,bluetooth,cfg80211

My connection can remain active for a long time but will occasionally
disconnect. Toggling Airplane Mode fixes the issue. Prolonged
downloads, such as a large video game, causes the connection to drop
several times. Toggling Airplane Mode lets the game begin download
each time.

I'm happy to provide as much info as necessary.

Thank you!

