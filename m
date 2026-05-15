Return-Path: <linux-wireless+bounces-36459-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HzRM0X9BmoeqgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36459-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:02:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 355E654DF96
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BE703199FDC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A7E466B5E;
	Fri, 15 May 2026 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZPgAmSZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52984508FC
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841728; cv=none; b=g/Cx53oLkml0IIraiem81M+ld0Up8zDVZTl0rfV9+poCTy3AtypD8pZGTu8ORxqH+Hr2Nrx3giqmGrD5hK0KFbCe0NYW6DSIGsUinMI49GwkQMsfJvVokFWmCv+anHbxEB741D/xOD0b8g/dD7FPPwDN99eUGXJRB2Zgn6jyZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841728; c=relaxed/simple;
	bh=riZ/OlOGBLzc58fSiT4u7TCKTgAfPvns+GTxQD0wvX8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject; b=I9LFsAZCFLsPZtqXxD8vC2YmEd+Uc4lZuPOk4LqIvoU/lgcqwztQ9AbY1S7IaMQdfR+y2HK8oLVfQQh4DHXY8HLfcWrcibtZzPGynH207oZC/uBS4tQNkUOPWvxMSmqr6w1qIU2oxFGpYNXrogAmaXJGHC1mDOtLV//gaSHcCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZPgAmSZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso14092543a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778841725; x=1779446525; darn=vger.kernel.org;
        h=subject:cc:to:from:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=riZ/OlOGBLzc58fSiT4u7TCKTgAfPvns+GTxQD0wvX8=;
        b=pZPgAmSZBYRUj7fphTYM7TKhLSsFxZr/7++YUkvaFU1s/f5QdCr+R2oBSdNzGqehgn
         rbtYqkWiR29qBliB6LNa+orotPa44N9Hk/oKKHwASgqQ2uZdXNmEe7tuZs2pauUpK4dA
         Z2TBLJLvmz/dmu6mxULzDBLTHY9j9fO1uumldOTaD5rFg18LdlZUyHjBaY3rd4xAxvUa
         75SWbOFzXEjVcoO5blUxl1HZCs6uSfB+j9nUvYbS+V4mwd+9Tr9OoY+N1y/JMRirPJvj
         Jbvn+P1F5sfZ62r4EWYVQd8J/5Z620+2VNXOGucCY/DCaVM0tbrArzXByCnRicE3JaJL
         QCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778841725; x=1779446525;
        h=subject:cc:to:from:content-transfer-encoding:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riZ/OlOGBLzc58fSiT4u7TCKTgAfPvns+GTxQD0wvX8=;
        b=Dsjm7MwnrCnBrkivMr6Xht8+tofNTEglrT6lqyYEygNAvit1Xv3GX68Kam06I2EMPe
         UskisY5P5m9E+UytxCpSeGwfKLs14W1bDIJN4ZxcQ4EIWJVnrCvfMlEik5IRS3PlesbH
         zeFK9KenauMMiYwKktASyNLPXPdb6Uanq6nPJS7XVeb7MBg+Kyfx5GTKRJguNWDEuokB
         jmSQZTnSANH+SQ+Gs/wAZXLq2D3S/s816mWdNa66YNSB9iiqeR4hjpm8MN2mvtrXmlC8
         GPknR04oNXCdF6vWPPnQX6N+ZSiRUUX8v2ZMm4tW2SXrIkh8KYGQNeXIVaoksana8eLs
         imsw==
X-Gm-Message-State: AOJu0YwyVwahXGJVrxvL4chXa9VxFJ0TEUqFs/bR/cftiCSeki95tkyc
	1PmavE58J6ZrARpL5Uxynn7DsTPayp+F1fzg0J5xK4cxIzG9eQTYu113
X-Gm-Gg: Acq92OHVn4S0iGbqwaisWq0npMdYihSHtIYKsigcQUF7jge5SL71vPJsFglWGcFOEG2
	4mHbA6N53NShW3BemAJ9o1lLw/Dc8uPbdKjOBqeDKWQ85SdIzBnqtf5zTXUS66EU8MG3NagkKi6
	bmku5VnoBzp/dDmllxOCnJv4Pt5GV9by2XIyTZVmexRm/xxcXETtV4+XhJsnwHrQAYUIAWUH6Zs
	mrYqXMSDwDfzZZTg6+utoMBgd6TSf2YaxOB+5iP73P1nhD/KjkA0HrKDr7xOeS7yfqF9zXJ4g2x
	Dj6Xh2K9tw7XZyVzpjBfMYrrkhJ3sioxUBKRVbPge2cALOPT/PIHVGeKO99EwQ8PhsEbJ4t7bU4
	L8w2VpPVAXNAUANEeNFqheI/We3Yej/w+zS9EQL8teRi7IlI6DCaTTMfTu1eJ0BFV9cRMrh7AhD
	EZrVq7N24OHLhe+/rkz6/tKML5Ngn1vO6h9iDSr1s3HcTFTPEZn8swed+X20fALivuoL3cZ2J36
	lZHbihaFdc5/LsvxEAjAKtvnmST9GYL4crVcWQsOYL3T32DWhWZbcBFyIAMFFzIPnRAWeD4BJHv
	ad37IMPHazi4bBzpI4FySEvHaXuE
X-Received: by 2002:a17:907:98d:b0:bd0:cc2c:8a2d with SMTP id a640c23a62f3a-bd517a9855fmr167559266b.41.1778841725190;
        Fri, 15 May 2026 03:42:05 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ded6dfsm214041666b.39.2026.05.15.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:42:04 -0700 (PDT)
Message-ID: <6a06f87c.643c4978.1f1059.84ae@mx.google.com>
Date: Fri, 15 May 2026 03:42:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: security@kernel.org
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Subject: [PATCH] wifi: cfg80211: validate common_info length in ieee80211_mle_size_ok()
X-Rspamd-Queue-Id: 355E654DF96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36459-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mx.google.com:mid]
X-Rspamd-Action: no action

SGkgR3JlZywKCkhlcmUgaXMgdGhlIGZpeC4KCkFsZXhhbmRydQoKLS0tCgpGb3IgTUxFIHR5cGVz
IHdpdGggYSBjb21tb25faW5mbyBsZW5ndGggZmllbGQgKEJBU0lDLCBQUkVRLCBURExTKSwKaWVl
ZTgwMjExX21sZV9zaXplX29rKCkgY2hlY2tzIHRoYXQgdmFyaWFibGVbMF0gaXMgYXQgbGVhc3Qg
YXMgbGFyZ2UgYXMKdGhlIG1hbmRhdG9yeSBmaWVsZHMsIGJ1dCBpdCBkb2VzIG5vdCBjaGVjayB0
aGF0IHRoZSB2YWx1ZSBmaXRzIHdpdGhpbgp0aGUgZWxlbWVudCBpdHNlbGYuCgpjZmc4MDIxMV9k
ZWZyYWdfbWxlKCkgY29tcHV0ZXMgdGhlIHN1Yi1lbGVtZW50IGFyZWEgc3RhcnQgYXM6CgogICAg
Y29tbW9uX3NpemUgPSBpZWVlODAyMTFfbWxlX2NvbW1vbl9zaXplKCh1OCAqKXJlcy0+bWxlKTsK
ICAgIGllID0gcmVzLT5kYXRhICsgY29tbW9uX3NpemU7CiAgICBpZWxlbiA9IG1sZV9sZW4gLSBj
b21tb25fc2l6ZTsKCmllZWU4MDIxMV9tbGVfY29tbW9uX3NpemUoKSByZXR1cm5zIHNpemVvZigq
bWxlKSArIG1sZS0+dmFyaWFibGVbMF0uCklmIHZhcmlhYmxlWzBdIGlzIGxhcmdlciB0aGFuIHRo
ZSBhY3R1YWwgZWxlbWVudCwgY29tbW9uX3NpemUgZXhjZWVkcwptbGVfbGVuIGFuZCB0aGUgc2l6
ZV90IHN1YnRyYWN0aW9uIHdyYXBzLiBmb3JfZWFjaF9lbGVtZW50X2lkKCkgdGhlbgppdGVyYXRl
cyBvdmVyIGFyYml0cmFyeSBrZXJuZWwgaGVhcCBtZW1vcnkgcGFzdCB0aGUgYWxsb2NhdGlvbi4K
CkFkZCB0aGUgbWlzc2luZyB1cHBlci1ib3VuZCBjaGVjayBzbyB2YXJpYWJsZVswXSBjYW5ub3Qg
ZXhjZWVkIHRoZQplbGVtZW50IHNpemUuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgSG9zc3Ug
PGhvc3N1LmFsZXhhbmRydUBnbWFpbC5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9pZWVlODAyMTEt
ZWh0LmggfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2llZWU4MDIxMS1laHQuaCBiL2luY2x1ZGUvbGludXgvaWVlZTgw
MjExLWVodC5oCmluZGV4IDg3ZDkyZmI4NmZhYi4uNzM4YTU4MWMzNjgzIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L2llZWU4MDIxMS1laHQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2llZWU4MDIx
MS1laHQuaApAQCAtOTA4LDYgKzkwOCwxMCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaWVlZTgwMjEx
X21sZV9zaXplX29rKGNvbnN0IHU4ICpkYXRhLCBzaXplX3QgbGVuKQogCWlmICghY2hlY2tfY29t
bW9uX2xlbikKIAkJcmV0dXJuIHRydWU7CgorCS8qIGNvbW1vbl9pbmZvIGxlbmd0aCBtdXN0IG5v
dCBleGNlZWQgdGhlIGVsZW1lbnQgKi8KKwlpZiAobGVuIDwgZml4ZWQgKyBtbGUtPnZhcmlhYmxl
WzBdKQorCQlyZXR1cm4gZmFsc2U7CisKIAkvKiBpZiBwcmVzZW50LCBjb21tb24gbGVuZ3RoIGlz
IHRoZSBmaXJzdCBvY3RldCB0aGVyZSAqLwogCXJldHVybiBtbGUtPnZhcmlhYmxlWzBdID49IGNv
bW1vbjsKIH0K

