Return-Path: <linux-wireless+bounces-30208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A55FCEB4C2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 06:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67C9230204A5
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 05:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD79A30FF1D;
	Wed, 31 Dec 2025 05:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zacbowling-com.20230601.gappssmtp.com header.i=@zacbowling-com.20230601.gappssmtp.com header.b="WIGORIqx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7340274B4A
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767159002; cv=none; b=D22Ufzq5wXgVzxuiqbcnr07XbswthkdK5vR+TTd21IVi4VoeT6lFcw1m1EC33x6DX+41wZgauuRTg0wLCQFdEcMztHX6ze5odVbVXXh+QNBLpbafzYowoc1b19mFluVFwGY7OPKycxccaUFsIxb4kpdLpW85KnQ7H/hoLRSkiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767159002; c=relaxed/simple;
	bh=rRXfrojVXq/HBXH8iXD11cckP9+GnyngGC/+RggZXxM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mtQSxfo0IE7ZUhTWOHbvVBaMmrDOR9E8xlSChTxB7wFq+2QADVbYDEwZw/qLoFP+s5HrKV7i8v2cKdfIjytnkBQdH+ZV5weCsxj7EbcAZhkASouLZdGEx12CPRncqNHTbq6RL3nNZN6NZZhsu8shtWr5jueOmpllUappsmRmykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=fail smtp.mailfrom=zacbowling.com; dkim=pass (2048-bit key) header.d=zacbowling-com.20230601.gappssmtp.com header.i=@zacbowling-com.20230601.gappssmtp.com header.b=WIGORIqx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zacbowling.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37b9d8122fdso86371541fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 21:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zacbowling-com.20230601.gappssmtp.com; s=20230601; t=1767158997; x=1767763797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sHKEzk3eiDkWr/mHmCD5Kjkc96F4fxGo9YLhfmfwt4I=;
        b=WIGORIqx61FQX3S5BNBA59wQUikDdTXkUJf6xkJLGQEZiRcl1yCsFX5+yXSHFsD2pS
         1Jl11u4k0zzwgPXvvZJzGDI9YisjDy6YSwaafBfYwCfMDhmxAepBYDFwHawVBbh1dB9o
         60p5SLtkvX53PnKyUSaTl2UOEvfWp2l4/L3haC7iMwSv8c5sNkQU0GbZxRsrVwdb1fGb
         rj7RJfrQ8gSDO0H2dZo+vJdDV7Qw8UPy1DCtpMxzhDDUIm7TuALvw/KkwQsQN+1qhVIu
         eROTgLSr0bKqMjU61i6SLtNYzQcL8jp65yM7+z6J+fM5fHhPix5Wi05AOnPu4aqTw+5L
         7wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767158997; x=1767763797;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHKEzk3eiDkWr/mHmCD5Kjkc96F4fxGo9YLhfmfwt4I=;
        b=vh+eFM+2Z6UEZs9fYuH6DsbPPVqo4jUFeYiAw+IwoYgvZBwa2Iepe5R/XMAHsflDNv
         SyjQLnAI4vb5S5SpCgmoLYpUzbHDJx7CpOi5nixuctbgnpQHUEi+xQiGdPno0Zs+sSbo
         NIsuH4jvXwAYlEVOsm8Sxa458Ud0s8eKclz1CPUFu8W1GeoAQ3NRpRmKd36Cl0SVbVUD
         xI82oV8+caQBcb7TGyOtFe3LsrPZaSusTLtHCCp7wioJiYvtP3q+y1j6kZbylbAqrDCU
         5do55sGPXDd3kLZLvHbto7C9g+72pcAnN0Co1OsJY1OMcTJjgu4ddX/CHdgt2w9ufxIs
         VQTw==
X-Gm-Message-State: AOJu0Yys4WDxKhsoZ50wwaZ7/zRD7s+s5qGxdpYd9ZS0pgRaD0HLITcW
	yBgbXXGefM8MGeWwiiUwgUwc9FMQ4hvx2kt2GzBwtEU/xcWnjGS5sBk7PAJ8D/IQCu5dy1fJXcV
	rvnJ00mgdSbcrKHjC5U1KCdR//wu5kBlEvsRVTK5aVXImbOINwbW/oFib3C1i
X-Gm-Gg: AY/fxX44vctwWPOVtVyG2RswW36KtB4G+e4lvkmmEozidAfMkVdxp/2ZfTNwQnJVhev
	ypnxbltL9WRfyZk7Q2Wd/fmQEMnwuKrGXrxdQLxYAyf1VX+1jf054Km9FKE33JMSdrv8ZtWWNJO
	pj0mM6onTPUwldBrIYE8oykjmf6MuqOzrSGVr9UeZdtxg4Z+b9Le8sdB+eZj2HbLSkQmSfP8/+Q
	SUxAyv027cneyorxuogwNRwQ6cqMVPLfshI56sZp070jGVFAv0jjkhfyep0f/lmxF7xHc/yW8ZE
	rxs6/bTSb69LW8YUskEaIiMDu1cx4gCF9Y6G
X-Google-Smtp-Source: AGHT+IGDUCXI56/dlMWNu29haOFoqFvTITaetCiiOEFP86knLXB3YNbN2QcQpknZHxUdToz96MXCmldzsEzuMZlPLJQ=
X-Received: by 2002:a05:651c:550:b0:37b:9977:7e62 with SMTP id
 38308e7fff4ca-3812164303bmr101593511fa.31.1767158996737; Tue, 30 Dec 2025
 21:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zac Bowling <zac@zacbowling.com>
Date: Tue, 30 Dec 2025 21:29:44 -0800
X-Gm-Features: AQt7F2rCJdqAr_4RJVPogHhFbL_7i8uMhusDazpEeOOcQ4vLEEocid67AfQWDFk
Message-ID: <CAA5_Hq7vNOy9oCGkkgyukq2OP=a5yL_3ZKBdmNtBXS+zp6byiQ@mail.gmail.com>
Subject: [PATCH] wifi: mt76: mt7925: fix NULL pointer dereference in vif
 iteration loops
To: linux-wireless@vger.kernel.org
Cc: lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, kvalo@kernel.org, 
	sean.wang@mediatek.com, deren.wu@mediatek.com, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004347a5064738c41f"

--0000000000004347a5064738c41f
Content-Type: text/plain; charset="UTF-8"

I was getting a kernel panic on my new Framework Desktop running
Ubuntu 25.10 with this specific WIFI chipset.

mt792x_vif_to_bss_conf() can return NULL when iterating over valid_links
during HW reset or other state transitions, because the link configuration
in mac80211 may not be set up yet even though the driver's valid_links
bitmap has the link marked as valid.

This causes a NULL pointer dereference in mt76_connac_mcu_uni_add_dev()
when it tries to access bss_conf->vif->type, and similar crashes in other
functions that use bss_conf without checking.

The crash manifests as:
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:mt76_connac_mcu_uni_add_dev+0xba/0x1f0 [mt76_connac_lib]
  Call Trace:
   mt7925_vif_connect_iter+0xcb/0x240 [mt7925_common]
   __iterate_interfaces+0x92/0x130 [mac80211]
   ieee80211_iterate_interfaces+0x3d/0x60 [mac80211]
   mt7925_mac_reset_work+0x105/0x190 [mt7925_common]

Add NULL checks for bss_conf in all loops that iterate over valid_links
and call mt792x_vif_to_bss_conf(), skipping links where the mac80211
link configuration is not yet available.

Reported-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>

--0000000000004347a5064738c41f
Content-Type: application/octet-stream; 
	name="0001-wifi-mt76-mt7925-fix-NULL-pointer-dereference-in-vif.patch"
Content-Disposition: attachment; 
	filename="0001-wifi-mt76-mt7925-fix-NULL-pointer-dereference-in-vif.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mjtkmyu90>
X-Attachment-Id: f_mjtkmyu90

RnJvbSA2NzkwZTY1NjAzMGZiMjM1MjdhYTVjMGQ2ZWFhMjhjZTAyOTMzNWIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaYWMgQm93bGluZyA8emFjQHphY2Jvd2xpbmcuY29tPgpEYXRl
OiBUdWUsIDMwIERlYyAyMDI1IDIwOjMyOjU2IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gd2lmaTog
bXQ3NjogbXQ3OTI1OiBmaXggTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIHZpZgogaXRlcmF0
aW9uIGxvb3BzCgptdDc5MnhfdmlmX3RvX2Jzc19jb25mKCkgY2FuIHJldHVybiBOVUxMIHdoZW4g
aXRlcmF0aW5nIG92ZXIgdmFsaWRfbGlua3MKZHVyaW5nIEhXIHJlc2V0IG9yIG90aGVyIHN0YXRl
IHRyYW5zaXRpb25zLCBiZWNhdXNlIHRoZSBsaW5rIGNvbmZpZ3VyYXRpb24KaW4gbWFjODAyMTEg
bWF5IG5vdCBiZSBzZXQgdXAgeWV0IGV2ZW4gdGhvdWdoIHRoZSBkcml2ZXIncyB2YWxpZF9saW5r
cwpiaXRtYXAgaGFzIHRoZSBsaW5rIG1hcmtlZCBhcyB2YWxpZC4KClRoaXMgY2F1c2VzIGEgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIG10NzZfY29ubmFjX21jdV91bmlfYWRkX2RldigpCndo
ZW4gaXQgdHJpZXMgdG8gYWNjZXNzIGJzc19jb25mLT52aWYtPnR5cGUsIGFuZCBzaW1pbGFyIGNy
YXNoZXMgaW4gb3RoZXIKZnVuY3Rpb25zIHRoYXQgdXNlIGJzc19jb25mIHdpdGhvdXQgY2hlY2tp
bmcuCgpUaGUgY3Jhc2ggbWFuaWZlc3RzIGFzOgogIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAwMAogIFJJUDogMDAxMDptdDc2X2Nv
bm5hY19tY3VfdW5pX2FkZF9kZXYrMHhiYS8weDFmMCBbbXQ3Nl9jb25uYWNfbGliXQogIENhbGwg
VHJhY2U6CiAgIG10NzkyNV92aWZfY29ubmVjdF9pdGVyKzB4Y2IvMHgyNDAgW210NzkyNV9jb21t
b25dCiAgIF9faXRlcmF0ZV9pbnRlcmZhY2VzKzB4OTIvMHgxMzAgW21hYzgwMjExXQogICBpZWVl
ODAyMTFfaXRlcmF0ZV9pbnRlcmZhY2VzKzB4M2QvMHg2MCBbbWFjODAyMTFdCiAgIG10NzkyNV9t
YWNfcmVzZXRfd29yaysweDEwNS8weDE5MCBbbXQ3OTI1X2NvbW1vbl0KCkFkZCBOVUxMIGNoZWNr
cyBmb3IgYnNzX2NvbmYgaW4gYWxsIGxvb3BzIHRoYXQgaXRlcmF0ZSBvdmVyIHZhbGlkX2xpbmtz
CmFuZCBjYWxsIG10NzkyeF92aWZfdG9fYnNzX2NvbmYoKSwgc2tpcHBpbmcgbGlua3Mgd2hlcmUg
dGhlIG1hYzgwMjExCmxpbmsgY29uZmlndXJhdGlvbiBpcyBub3QgeWV0IGF2YWlsYWJsZS4KClJl
cG9ydGVkLWJ5OiBaYWMgQm93bGluZyA8emFjQHphY2Jvd2xpbmcuY29tPgpTaWduZWQtb2ZmLWJ5
OiBaYWMgQm93bGluZyA8emFjQHphY2Jvd2xpbmcuY29tPgotLS0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1L21hYy5jICB8IDYgKysrKysrCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyNS9tYWluLmMgfCA4ICsrKysrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkyNS9tYWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTI1L21hYy5jCmluZGV4IDg3MWI2NzEwMS4uMTg0ZWZlOGFmIDEwMDY0
NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyNS9tYWMuYwor
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyNS9tYWMuYwpAQCAt
MTI3MSw2ICsxMjcxLDEyIEBAIG10NzkyNV92aWZfY29ubmVjdF9pdGVyKHZvaWQgKnByaXYsIHU4
ICptYWMsCiAJCWJzc19jb25mID0gbXQ3OTJ4X3ZpZl90b19ic3NfY29uZih2aWYsIGkpOwogCQlt
Y29uZiA9IG10NzkyeF92aWZfdG9fbGluayhtdmlmLCBpKTsKIAorCQkvKiBTa2lwIGxpbmtzIHRo
YXQgZG9uJ3QgaGF2ZSBic3NfY29uZiBzZXQgdXAgeWV0IGluIG1hYzgwMjExLgorCQkgKiBUaGlz
IGNhbiBoYXBwZW4gZHVyaW5nIEhXIHJlc2V0IHdoZW4gbGluayBzdGF0ZSBpcyBpbmNvbnNpc3Rl
bnQuCisJCSAqLworCQlpZiAoIWJzc19jb25mKQorCQkJY29udGludWU7CisKIAkJbXQ3Nl9jb25u
YWNfbWN1X3VuaV9hZGRfZGV2KCZkZXYtPm1waHksIGJzc19jb25mLCAmbWNvbmYtPm10NzYsCiAJ
CQkJCSAgICAmbXZpZi0+c3RhLmRlZmxpbmsud2NpZCwgdHJ1ZSk7CiAJCW10NzkyNV9tY3Vfc2V0
X3R4KGRldiwgYnNzX2NvbmYpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MjUvbWFpbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MjUvbWFpbi5jCmluZGV4IDJkMzU4YTk2Ni4uMzAwMWE2MmE4IDEwMDY0NAotLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyNS9tYWluLmMKKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjUvbWFpbi5jCkBAIC0xMzA0
LDYgKzEzMDQsOCBAQCBtdDc5MjVfbWxvX3BtX2l0ZXIodm9pZCAqcHJpdiwgdTggKm1hYywgc3Ry
dWN0IGllZWU4MDIxMV92aWYgKnZpZikKIAltdDc5MnhfbXV0ZXhfYWNxdWlyZShkZXYpOwogCWZv
cl9lYWNoX3NldF9iaXQoaSwgJnZhbGlkLCBJRUVFODAyMTFfTUxEX01BWF9OVU1fTElOS1MpIHsK
IAkJYnNzX2NvbmYgPSBtdDc5MnhfdmlmX3RvX2Jzc19jb25mKHZpZiwgaSk7CisJCWlmICghYnNz
X2NvbmYpCisJCQljb250aW51ZTsKIAkJbXQ3OTI1X21jdV91bmlfYnNzX3BzKGRldiwgYnNzX2Nv
bmYpOwogCX0KIAltdDc5MnhfbXV0ZXhfcmVsZWFzZShkZXYpOwpAQCAtMTYzMCw2ICsxNjMyLDgg
QEAgc3RhdGljIHZvaWQgbXQ3OTI1X2lwdjZfYWRkcl9jaGFuZ2Uoc3RydWN0IGllZWU4MDIxMV9o
dyAqaHcsCiAKIAlmb3JfZWFjaF9zZXRfYml0KGksICZ2YWxpZCwgSUVFRTgwMjExX01MRF9NQVhf
TlVNX0xJTktTKSB7CiAJCWJzc19jb25mID0gbXQ3OTJ4X3ZpZl90b19ic3NfY29uZih2aWYsIGkp
OworCQlpZiAoIWJzc19jb25mKQorCQkJY29udGludWU7CiAJCV9fbXQ3OTI1X2lwdjZfYWRkcl9j
aGFuZ2UoaHcsIGJzc19jb25mLCBpZGV2KTsKIAl9CiB9CkBAIC0xODYxLDYgKzE4NjUsOCBAQCBz
dGF0aWMgdm9pZCBtdDc5MjVfdmlmX2NmZ19jaGFuZ2VkKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
LAogCWlmIChjaGFuZ2VkICYgQlNTX0NIQU5HRURfQVJQX0ZJTFRFUikgewogCQlmb3JfZWFjaF9z
ZXRfYml0KGksICZ2YWxpZCwgSUVFRTgwMjExX01MRF9NQVhfTlVNX0xJTktTKSB7CiAJCQlic3Nf
Y29uZiA9IG10NzkyeF92aWZfdG9fYnNzX2NvbmYodmlmLCBpKTsKKwkJCWlmICghYnNzX2NvbmYp
CisJCQkJY29udGludWU7CiAJCQltdDc5MjVfbWN1X3VwZGF0ZV9hcnBfZmlsdGVyKCZkZXYtPm10
NzYsIGJzc19jb25mKTsKIAkJfQogCX0KQEAgLTE4NzYsNiArMTg4Miw4IEBAIHN0YXRpYyB2b2lk
IG10NzkyNV92aWZfY2ZnX2NoYW5nZWQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsCiAJCQl9IGVs
c2UgaWYgKG12aWYtPm1sb19wbV9zdGF0ZSA9PSBNVDc5MnhfTUxPX0NIQU5HRURfUFMpIHsKIAkJ
CQlmb3JfZWFjaF9zZXRfYml0KGksICZ2YWxpZCwgSUVFRTgwMjExX01MRF9NQVhfTlVNX0xJTktT
KSB7CiAJCQkJCWJzc19jb25mID0gbXQ3OTJ4X3ZpZl90b19ic3NfY29uZih2aWYsIGkpOworCQkJ
CQlpZiAoIWJzc19jb25mKQorCQkJCQkJY29udGludWU7CiAJCQkJCW10NzkyNV9tY3VfdW5pX2Jz
c19wcyhkZXYsIGJzc19jb25mKTsKIAkJCQl9CiAJCQl9Ci0tIAoyLjUxLjAKCg==
--0000000000004347a5064738c41f--

