Return-Path: <linux-wireless+bounces-24329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3480AE3307
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 02:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B7E188E6BD
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 00:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5521FF2B;
	Mon, 23 Jun 2025 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="le/9UpZX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3961D799D
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750636823; cv=none; b=p6n1oBUcvRlJ7VGxKonQrLMm4pIr8Ub1TT2X1pkP0I58qxAQb130CT70roQTfVpym4Pgw3BLbfr+t5n0m/ZPB3/LG0B8yqgP069lQpgnOdiCR/2GeX8sW5a+gtBuUVRJ6w1b5vGE7hJfu9cNAcJZN0c05hQjwnkcqg9l874BnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750636823; c=relaxed/simple;
	bh=kPFEp+DgFgPN5/Q8vbl7679/mZEZ8m7Gi2RB1XraLNo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f7RzwLKkuuSqIWer0EgDbHkLOTLg3g9/JLOU/XtppK/Kgm3rOMtohHRe6W+JGudPoVd1/AgvO/P5CaS6HOp7S+jMc99Zfn3PA3iVPw7dLDAVmFkYyVEg0HmdPW9MapGySiy8k69uXYnCdbFYvPMmD8ZH6AyO1D5HLc5fCXe/nZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=le/9UpZX; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so2987341276.3
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750636818; x=1751241618; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsUqh5KfGmtfMMkvC2Jq3US5g0bcIW06yFVOpYy+eOo=;
        b=le/9UpZXNpmhO5km/GmZWZ2crBoKYQ+1+2UnuBQ6tOagrnZEnFrX50P4aQEVBtX1Wj
         3+HTzDgWjQuIFtt0mEHFPpLDKRtEsF8jb/XN0t3+HYxDCeI1N3TPTiSgDw7xW69bnDjK
         MLkuIzeZcjLdj2p3/mnkGPc8CuBpB9lXLlBXYqt2nd5EeplnXcF8z0WDj51yno6wncN2
         0wVSVo0gi27Sdi6vyqX6qLu7rH89E0ScMcNhRiMzaC19xJA7sN0P/HiCWGvaOz1gboDh
         8tjX5wSLYAOjnjZnUA1oxZjZWFdAmx7x1scPOhzeEhotYF/spwkkZO7CUJFW/lb4RlYf
         Mb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750636818; x=1751241618;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsUqh5KfGmtfMMkvC2Jq3US5g0bcIW06yFVOpYy+eOo=;
        b=t+9HJ7y/I2YcYAla9ZHec066NP0AKsh8QHMiD2ieTQfOZXD6h3KR5/2rE//i83cODb
         vZaxYErV3gtboq7yZKoOO2FICZ72P2Rm4Kv/JXKjKfh7IWHpkRZAf4XT/+yAHaO4qVAT
         pNSQh9FUo2hIkxRWwJ/LBS5KfBhjG83m4VacO8xhG/sK+mdBpOAG2GkajEASJUVZGKeh
         rKgdgEpeSaocaPVbZClW760ulqWvyOwU3LYW5dV9PCRqo6F/3AkPWYkmtiy0UskcGSd1
         fDQ0XKXl8TVD/Gz0ewuGEVMWs3JH3QkKC3uNhChRO10laANyKeR4f0XZNx83K3JgbavG
         dGyg==
X-Forwarded-Encrypted: i=1; AJvYcCUIyGoWj1CqJPg0NuL+PuNqdpQTWplJlLHDPbTFCb58VTeQHzxP8PF1mEzr8ec8DdBP2k5wvBHt8Raa+gSWWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrer6IVagKp0uFlgx2nK89Lqvtt3x4MhHA+jIxPuuksk0P+l5
	v/8RxyL+TeHTg/C9r+Il3fNj5BKGNIgyXZaRVEd7KL8SU5adSGSXwcaVy1Ol3H6g4w==
X-Gm-Gg: ASbGnct3dpRW84x7mlQB7MEHfJJ7dyLkKjzcHtNngf5LMBwsQkwNAtMLxz53a2mI7iY
	hyp/bs2hPSFn2+oGHva0f26DnXGwI49asO+tw2M4OCvSrVgzCU6PQSPouam0gWDqAJVJ5ipG8zL
	OTZ3t95lxul0G0pwHWCVdRsrd89aupKDF7/zk0h3jIuWeEYT8KdP7n4namLEX1baHls5DKQnpYu
	EezuVqepdglY87n+1RuiIQDfsCVhgZDJqAvAm7SMpzfe37caG2Ys+2QeA0b4H8VCRGReTcNUgya
	VgYePn2lNaQVPbA26kXBWp3Jn6PHC8rqA7dxmtv1PB9aE2Sr3dQGKrvaeQ7YoXY0VoMQAOg5Lh0
	Q1GlM4ldcvZEHuxvcEok5jpkMdaI0Dby1sEvnQLBbBL6ZJq4=
X-Google-Smtp-Source: AGHT+IFSPg2FJgymL+0Ql0jhxbj7TlYr+9kn3/WtUrsZejd/BQVFr3O4trGSNIfGmN2s9p2p6qN6DA==
X-Received: by 2002:a05:6902:2ec4:b0:e84:49d8:77c with SMTP id 3f1490d57ef6-e8449d80fe2mr3228632276.28.1750636818028;
        Sun, 22 Jun 2025 17:00:18 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ab0a7d9sm2139664276.24.2025.06.22.17.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 17:00:16 -0700 (PDT)
Date: Sun, 22 Jun 2025 17:00:04 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Damian Tometzki <damian@riscv-rocks.de>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: wlwifi AX201: WARN_ON in iwl_mvm_mld_mac_ctxt_cmd_common repeated
 UMAC FW crashes on 6.16-rc2
In-Reply-To: <CAL=B37mqrHOzEQzPX3=6S5XaUZexYRUXNBgUuGsiX6+4iHWO8g@mail.gmail.com>
Message-ID: <e179da27-feb6-36fe-0a3b-bc24fb00b62d@google.com>
References: <aFgvmhSbup2BnUHu@fedora> <CAL=B37mqrHOzEQzPX3=6S5XaUZexYRUXNBgUuGsiX6+4iHWO8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1164435157-1750636816=:2472"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1164435157-1750636816=:2472
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 22 Jun 2025, Damian Tometzki wrote:
> On Sun, Jun 22, 2025 at 6:30=E2=80=AFPM Damian Tometzki <damian@riscv-roc=
ks.de> wrote:
> >
> > Hi Miri,
> > Hi all,
> >
> > with v6.16-rc2 I consistently hit a Wi-Fi firmware crash on a
> > Lenovo ThinkPad X1 Carbon Gen 9.
> >
> > Hardware / FW
> > -------------
> >  * NIC  : Intel Wi-Fi 6 AX201 160 MHz (PCI ID a0f0:0070, rev 0x351)
> >  * FW   : 77.864baa2e.0 QuZ-a0-hr-b0-77.ucode (auto-loaded)
> >  * BIOS : N32ET96W (1.72)
> >  * Platform: 20XWCTO1WW
> >
> > Kernel: 6.16.0-rc2 #440 PREEMPT(lazy)
> >
> > Symptoms
> > --------
> > Immediately after NetworkManager (or plain `ip link set wlp0s20f3 up`)
> > the driver warns:
> >
> >     WARNING at drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c:37
> >     iwl_mvm_mld_mac_ctxt_cmd_common+0x175/0x1d0
> >
> > The firmware then aborts:
> >
> >     FW error in SYNC CMD MAC_CONFIG_CMD
> >     NMI_INTERRUPT_UMAC_FATAL
> >     ADVANCED_SYSASSERT 0x20103126
> >     Microcode SW error detected. Restarting 0x0.
> >
> > The cycle repeats every few seconds; the interface never becomes usable=
=2E
> > Full dmesg attached.
> >
> > --
> > VG
> > Demian Tometzki
>=20
> Hi together,
>=20
> I identified commit 83f3ac2848b46e3e5af5d06b5f176c as the cause of the is=
sue.
> After reverting it, the system is working again.
>=20
> Best regards
> Damian

I have a similar Lenovo X1 Carbon Gen 9: saw no problem on rc1 or rc2,
but vey much this problem on today's 6.16-rc3.

Patch from Miri's reply (attachment without context so I'm replying
to this not that) inlined below, works nicely for me: thank you.
I've removed Change-Id and Organization tags.

Hugh

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Date: Sun, 22 Jun 2025 23:42:04 +0300
Subject: [PATCH] wifi: iwlwifi: mvm: assume '1' as the default mac_config_c=
md
 version

Unfortunately, FWs of some devices don't have the version of the
iwl_mac_config_cmd defined in the TLVs. We send 0 as the 'def argument
to  iwl_fw_lookup_cmd_ver, so for such FWs, the return value will be 0,
leading to a warning, and to not sending the command.

Fix this by assuming that the default version is 1.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net=
/wireless/intel/iwlwifi/mvm/mld-mac.c
index 3c255ae916c8..48ab6a2a98cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -32,7 +32,7 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mv=
m *mvm,
 =09unsigned int link_id;
 =09int cmd_ver =3D iwl_fw_lookup_cmd_ver(mvm->fw,
 =09=09=09=09=09    WIDE_ID(MAC_CONF_GROUP,
-=09=09=09=09=09=09    MAC_CONFIG_CMD), 0);
+=09=09=09=09=09=09    MAC_CONFIG_CMD), 1);
=20
 =09if (WARN_ON(cmd_ver < 1 || cmd_ver > 3))
 =09=09return;
--=20
2.34.1
---1463770367-1164435157-1750636816=:2472--

