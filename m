Return-Path: <linux-wireless+bounces-34652-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5+wmBAxC22li/AgAu9opvQ
	(envelope-from <linux-wireless+bounces-34652-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 08:56:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99B3E2F4E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 08:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78307301413B
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 06:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FA381732;
	Sun, 12 Apr 2026 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOIbEP+S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43838DF6C
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775976968; cv=pass; b=XUukyarPb/1yJdz6ws/oWsa+EDA/GfFrq7XEFkSC8kRXipkQ4et/4aCICSVasSdmR1xYXupRft9rJPQw+04/a2YJm+RJ6ybPwqF80qZaXguoOEBqaLbJzRZoGemhXjkeF1hIZ1BhhJZLxwXdXzZWsWzMNJEc+Bt+NvvyLqdnJtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775976968; c=relaxed/simple;
	bh=qK0UKkos5RdgXNmudCNEJqqdkRK6paC0K6t5Jqb7W8E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Kc3iFjrGg3rQOod1VZdGsemd0JTYBvUPYvcCDLXgJC1EUk1UX95rxYOGddwy8dbgIxdNJCK45XaeWsgm696I/HEEV3kgjlA6a9zK1Hidt6ng14B2PTwa7A6JynwguAgQfo9UHVfFYOawMi91HLhdNqgbNTw2oCWDGhgtAThHdQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOIbEP+S; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so521235866b.0
        for <linux-wireless@vger.kernel.org>; Sat, 11 Apr 2026 23:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775976965; cv=none;
        d=google.com; s=arc-20240605;
        b=Xk9lDRQYVXDiujNntJJG1MeMAlgpTINGxyVRSzk8YQbksJ907hJqsvLRIxKVVKmpL1
         8CZHj0VGuLVg8FL4eRVeoGfb8BUC3G/hiv+1wIF5N7BDPr1uSXxDoACXjxn/7+g/i9Lb
         2JfCG+SMO2ElGBSxHszS9YuMkpatI9jwWUXprvo9+3t+Vr+XfErhC7gm0hH5DEzST80o
         S4FyjcXqCehkfSbDmRvEbcAQ6ODN7Ak2MBQhkSwtn/3FcFT0b1emFtujk9sDcit+4iFN
         phGUqpqKCWskVmG6/DssE0+TkGjPbGkZisda/6Nub3I0B/GFARcCIctIk8rT4rSTNoDy
         4P3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8CccL86XTK9DKd0GowQJKm5xXWNtJRMj1u3nx8p68RY=;
        fh=ELCPnh14E5kB/AYC6kiERFMHc49Z23voZ9JQ6Qp/dxk=;
        b=HKhOa/051mRuf0qVCGUsmwclkhfaSZ19Sg4Cx/7FVF8/Zu0XG/QYAbwwVSnKsJNNin
         +TCTdZSgA4W8sNdG+6mSWhuv2OD5/gjuRFL7I3geSHzFnCw7Y71dVpRvB+hz5mwrWBBz
         bSIHKuVJbwrrQyNt9L6DaoKfJM3OgwRQbTifeePme1ffCbrVUR3Slp4pKVf257cqxpe8
         Nvj+zBl1CLrBwYTVfs35TdJWkq4dzltTKIzTfI1CfQHKUgMuZsnWaJsgs9cEIGvZZjfx
         C9BRLx5QmtGIUg9/Jbn5YQVN27A488Vy6UiUNsMt5ywlwq98taP1DEjW+peKe+Wxvjrf
         7ssQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775976965; x=1776581765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8CccL86XTK9DKd0GowQJKm5xXWNtJRMj1u3nx8p68RY=;
        b=AOIbEP+SZBj1A95MIxY19KGrsM5LUvikjvcqMf/cnAjFfbZLBpO4MsFqJTPAcw/haJ
         KHPFlXMoTKNYgHxwLgZnxs88P1IcoJ3r1twWne3ziFvLnPLv1YiovQ1oxF/g/gQhwbyn
         dSRbkm0g5fYJr4FTGGstAdm/9L1dtckeGIjGEpnwfNpXv0x84Sv2s4kPdY5nCAsm7kXZ
         jQRv7kN7xW7azeTF6EwnyAyAapeRAUvh36pGDv41cydlzF3UQPZACag1nPGbetLjwaIP
         PM0p7MGfwD1sVPRfTukEYnO/4oSMkRgmDDCs9sdk5zdxFe25K/aQU6NCHikpHiXt77aQ
         PYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775976965; x=1776581765;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CccL86XTK9DKd0GowQJKm5xXWNtJRMj1u3nx8p68RY=;
        b=UnDHlVfGdr9IW6Cl/nWKaVrg9Iam8UqGFZNndkOdB13uf8cckhQ5O72dRq7p+70XUA
         1yFSNdLMto8bRJlI6f0LD1QUh8CH5Nwbb3pI2XNRCygo/nAp5weVAz0WnfLHU/Mg49zF
         a6dsLA9O5SkxsQRbdhxB6ocz3XagC4U2M19ryr3DEX+Qf0h6XkZAO4B015CWOn2yLemu
         lhywOFSU8UGa8DtUPnvkcdYKYLoF/OQU5otuzMewOGaI76zcxPhQw7PuwLxFRBqWlJMx
         twIzVs4g1ptZfjxXboUdRYuqxlFbjkothyjOXow1rgNqRz/KYxZKOb/TTAvlgK8mdgsZ
         VNKA==
X-Gm-Message-State: AOJu0Yzq7s5OU/BkfKHoFOtUI8TKZzoxc+J4mIiZBHqSdMZnjT5faoLA
	nezIgqtSrXaIHzww+BsyA48mAmpWobQ8lHKNL0lvT+QOvq/vAYkmzLRG1U/fKHRHqTrDFkXFTCW
	LhToPwT87ay2hY3T6aZ0xMYhBPgMvqN414R6u4Is=
X-Gm-Gg: AeBDiesynHUSAr3zsZekm0xky2d2luxIkCDWgebldkgfEFb6TKIVwB8vodj/8FjLVIZ
	+B/sL9xAd2+yBwK0nP6tb5x9ffnFqdVrbn5fTtTkFOXprBDe8vXwrJcPKWSvZHmxU/nLUJv/F0b
	7iYmAhDe02nFgiS2amJ3PdQTLr5YRDnYsNcW0JC8c0CpSW6ocTFguEb8UpN0q3j6kl2h837NxBs
	rC4iMDNxZoShZdjDNO7CMfnuo+BFC5H26cjHypc9/lmI5T7pZ2N8x/hmHkPW8oHxCV8W6sgJZxd
	iOOTEcXm
X-Received: by 2002:a17:907:26c4:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b9d7260df98mr496060366b.15.1775976965018; Sat, 11 Apr 2026
 23:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aviel Zohar <avielzohar123@gmail.com>
Date: Sun, 12 Apr 2026 09:55:53 +0300
X-Gm-Features: AQROBzCI6x0cLjNo9At2APGcLrwRLBofDxmbiLvbde3kR9leohSZPA3Jkq_zGIY
Message-ID: <CAL8nUPbThnEA_jd=9QSLdkmqKpd=DPz78_qbaEonDEd6pnhoaQ@mail.gmail.com>
Subject: [PATCH 0/2] wifi: mt76: add missing skb length validation
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org, "nbd@nbd.name" <nbd@nbd.name>, lorenzo@kernel.org, 
	"sean.wang@mediatek.com" <sean.wang@mediatek.com>, "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>
Content-Type: multipart/mixed; boundary="000000000000215cda064f3ddc2f"
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain,text/x-diff];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34652-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avielzohar123@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 4F99B3E2F4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000215cda064f3ddc2f
Content-Type: multipart/alternative; boundary="000000000000215cd8064f3ddc2d"

--000000000000215cd8064f3ddc2d
Content-Type: text/plain; charset="UTF-8"

This series addresses missing skb length validation in two mt76
drivers before memcpy operations on firmware MCU responses.

In both cases, the driver copies a fixed number of bytes from
skb->data without first checking that skb->len is large enough.
If the firmware returns a shorter-than-expected response (due to a
bug, partial DMA transfer, or in the case of mt7925, a malicious
USB device), the memcpy reads beyond the skb data buffer, causing
a heap buffer over-read. The over-read data is subsequently
returned to userspace.

Patch 1: mt7925 testmode - mt7925_tm_query() copies 512 bytes
(MT7925_EVT_RSP_LEN) from skb->data + 8 without verifying
skb->len >= 520. The leaked data is returned via nla_put()
through nl80211 testmode dump. Fix adds a length check before
the memcpy.

Patch 2: mt7915 txpower - mt7915_mcu_get_txpower_sku() copies
up to 322 bytes (MT7915_SKU_RATE_NUM * 2) from skb->data + 4
without verifying skb->len. The data surfaces through debugfs
(txpower_sku, txpower_path). Fix adds length checks for both
the TX_POWER_INFO_RATE and TX_POWER_INFO_PATH code paths.

Both fixes follow the same pattern: validate skb->len before
performing the memcpy, returning -EINVAL on insufficient data.

Tested by code inspection; I do not have the hardware to
run-test these changes. (Please let me know if you want me to git send-mail
them as well)

[PATCH 1/2] wifi: mt76: mt7925: validate skb length in testmode query
[PATCH 2/2] wifi: mt76: mt7915: validate skb length in txpower SKU query

--000000000000215cd8064f3ddc2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">This series addresses missing skb length validation in tw=
o mt76<br>drivers before memcpy operations on firmware MCU responses.<br><b=
r>In both cases, the driver copies a fixed number of bytes from<br>skb-&gt;=
data without first checking that skb-&gt;len is large enough.<br>If the fir=
mware returns a shorter-than-expected response (due to a<br>bug, partial DM=
A transfer, or in the case of mt7925, a malicious<br>USB device), the memcp=
y reads beyond the skb data buffer, causing<br>a heap buffer over-read. The=
 over-read data is subsequently<br>returned to userspace.<br><br>Patch 1: m=
t7925 testmode - mt7925_tm_query() copies 512 bytes<br>(MT7925_EVT_RSP_LEN)=
 from skb-&gt;data + 8 without verifying<br>skb-&gt;len &gt;=3D 520. The le=
aked data is returned via nla_put()<br>through nl80211 testmode dump. Fix a=
dds a length check before<br>the memcpy.<br><br>Patch 2: mt7915 txpower - m=
t7915_mcu_get_txpower_sku() copies<br>up to 322 bytes (MT7915_SKU_RATE_NUM =
* 2) from skb-&gt;data + 4<br>without verifying skb-&gt;len. The data surfa=
ces through debugfs<br>(txpower_sku, txpower_path). Fix adds length checks =
for both<br>the TX_POWER_INFO_RATE and TX_POWER_INFO_PATH code paths.<br><b=
r>Both fixes follow the same pattern: validate skb-&gt;len before<br>perfor=
ming the memcpy, returning -EINVAL on insufficient data.<br><br>Tested by c=
ode inspection; I do not have the hardware to<br>run-test these changes. (P=
lease let me know if you want me to git send-mail them as well)<br><br>[PAT=
CH 1/2] wifi: mt76: mt7925: validate skb length in testmode query<br>[PATCH=
 2/2] wifi: mt76: mt7915: validate skb length in txpower SKU query=C2=A0</d=
iv>

--000000000000215cd8064f3ddc2d--
--000000000000215cda064f3ddc2f
Content-Type: text/x-diff; charset="US-ASCII"; 
	name="0002-wifi-mt76-mt7915-validate-skb-length-txpower.patch"
Content-Disposition: attachment; 
	filename="0002-wifi-mt76-mt7915-validate-skb-length-txpower.patch"
Content-Transfer-Encoding: base64
Content-ID: <19d80754f6eacfe7285>
X-Attachment-Id: 19d80754f6eacfe7285

RnJvbTogQXZpZWwgWm9oYXIgPGF2aWVsem9oYXIxMjNAZ21haWwuY29tPgpEYXRlOiBTYXQsIDEy
IEFwciAyMDI2IDAwOjAwOjAwICswMDAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIHdpZmk6IG10NzY6
IG10NzkxNTogdmFsaWRhdGUgc2tiIGxlbmd0aCBpbiB0eHBvd2VyIFNLVSBxdWVyeQoKSW4gbXQ3
OTE1X21jdV9nZXRfdHhwb3dlcl9za3UoKSwgdGhlIHJlc3BvbnNlIHNrYiBmcm9tCm10NzZfbWN1
X3NlbmRfYW5kX2dldF9tc2coKSBpcyB1c2VkIGluIG1lbWNweSB3aXRob3V0IHZhbGlkYXRpbmcK
aXRzIGxlbmd0aDoKCkZvciBUWF9QT1dFUl9JTkZPX1JBVEU6CiAgbWVtY3B5KHJlcywgc2tiLT5k
YXRhICsgNCwgc2l6ZW9mKHJlcykpOwoKd2hlcmUgc2l6ZW9mKHJlcykgaXMgTVQ3OTE1X1NLVV9S
QVRFX05VTSAqIDIgPSAzMjIgYnl0ZXMuCgpGb3IgVFhfUE9XRVJfSU5GT19QQVRIOgogIG1lbWNw
eSh0eHBvd2VyLCBza2ItPmRhdGEgKyA0LCBsZW4pOwoKSW4gYm90aCBjYXNlcywgaWYgdGhlIGZp
cm13YXJlIHJldHVybnMgYSByZXNwb25zZSBzaG9ydGVyIHRoYW4KdGhlIGV4cGVjdGVkIHNpemUs
IHRoZSBtZW1jcHkgcmVhZHMgYmV5b25kIHRoZSBza2IgZGF0YSBidWZmZXIuClRoZSBkYXRhIHN1
cmZhY2VzIHRvIHVzZXJzcGFjZSB2aWEgZGVidWdmcyAodHhwb3dlcl9za3UgYW5kCnR4cG93ZXJf
cGF0aCkuCgpBZGQgbGVuZ3RoIGNoZWNrcyBmb3IgYm90aCBjb2RlIHBhdGhzIGJlZm9yZSB0aGUg
bWVtY3B5LgoKU2lnbmVkLW9mZi1ieTogQXZpZWwgWm9oYXIgPGF2aWVsem9oYXIxMjNAZ21haWwu
Y29tPgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5j
IHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMKKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMKQEAgLTM1MzIsMTAgKzM1
MzIsMTggQEAKIAlpZiAoY2F0ZWdvcnkgPT0gVFhfUE9XRVJfSU5GT19SQVRFKSB7CiAJCXM4IHJl
c1tNVDc5MTVfU0tVX1JBVEVfTlVNXVsyXTsKIAorCQlpZiAoc2tiLT5sZW4gPCBzaXplb2YocmVz
KSArIDQpIHsKKwkJCWRldl9rZnJlZV9za2Ioc2tiKTsKKwkJCXJldHVybiAtRUlOVkFMOworCQl9
CiAJCW1lbWNweShyZXMsIHNrYi0+ZGF0YSArIDQsIHNpemVvZihyZXMpKTsKIAkJZm9yIChpID0g
MDsgaSA8IGxlbjsgaSsrKQogCQkJdHhwb3dlcltpXSA9IHJlc1tpXVtyZXEuYmFuZF9pZHhdOwog
CX0gZWxzZSBpZiAoY2F0ZWdvcnkgPT0gVFhfUE9XRVJfSU5GT19QQVRIKSB7CisJCWlmIChza2It
PmxlbiA8IGxlbiArIDQpIHsKKwkJCWRldl9rZnJlZV9za2Ioc2tiKTsKKwkJCXJldHVybiAtRUlO
VkFMOworCQl9CiAJCW1lbWNweSh0eHBvd2VyLCBza2ItPmRhdGEgKyA0LCBsZW4pOwogCX0K
--000000000000215cda064f3ddc2f
Content-Type: text/x-diff; charset="US-ASCII"; 
	name="0001-wifi-mt76-mt7925-validate-skb-length-testmode.patch"
Content-Disposition: attachment; 
	filename="0001-wifi-mt76-mt7925-validate-skb-length-testmode.patch"
Content-Transfer-Encoding: base64
Content-ID: <19d80754f6ea08c67e26>
X-Attachment-Id: 19d80754f6ea08c67e26

RnJvbTogQXZpZWwgWm9oYXIgPGF2aWVsem9oYXIxMjNAZ21haWwuY29tPgpEYXRlOiBTYXQsIDEy
IEFwciAyMDI2IDAwOjAwOjAwICswMDAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIHdpZmk6IG10NzY6
IG10NzkyNTogdmFsaWRhdGUgc2tiIGxlbmd0aCBpbiB0ZXN0bW9kZSBxdWVyeQoKSW4gbXQ3OTI1
X3RtX3F1ZXJ5KCksIHRoZSByZXNwb25zZSBza2IgZnJvbSBtdDc2X21jdV9zZW5kX2FuZF9nZXRf
bXNnKCkKaXMgdXNlZCBpbiBhIG1lbWNweSB3aXRob3V0IHZhbGlkYXRpbmcgaXRzIGxlbmd0aDoK
CiAgbWVtY3B5KGV2dF9yZXNwLCBza2ItPmRhdGEgKyA4LCBNVDc5MjVfRVZUX1JTUF9MRU4pOwoK
d2hlcmUgTVQ3OTI1X0VWVF9SU1BfTEVOIGlzIDUxMi4gSWYgdGhlIGZpcm13YXJlIHJldHVybnMg
YSByZXNwb25zZQpzaG9ydGVyIHRoYW4gNTIwIGJ5dGVzICg4ICsgNTEyKSwgdGhpcyByZWFkcyBi
ZXlvbmQgdGhlIHNrYiBkYXRhCmJ1ZmZlci4gVGhlIG92ZXItcmVhZCBkYXRhIGlzIHRoZW4gcmV0
dXJuZWQgdG8gdXNlcnNwYWNlIHZpYSBubGFfcHV0KCkKaW4gbXQ3OTI1X3Rlc3Rtb2RlX2R1bXAo
KS4KCkFkZCBhIGxlbmd0aCBjaGVjayBiZWZvcmUgdGhlIG1lbWNweSB0byBlbnN1cmUgdGhlIHNr
YiBjb250YWlucwpzdWZmaWNpZW50IGRhdGEuCgpGaXhlczogYzk0OGI1ZGE2YmJlICgid2lmaTog
bXQ3NjogbXQ3OTI1OiBhZGQgTWVkaWF0ZWsgV2ktRmk3IGRyaXZlciBmb3IgbXQ3OTI1IGNoaXBz
IikKU2lnbmVkLW9mZi1ieTogQXZpZWwgWm9oYXIgPGF2aWVsem9oYXIxMjNAZ21haWwuY29tPgot
LS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1L3Rlc3Rtb2RlLmMg
fCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgotLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyNS90ZXN0bW9kZS5jCisrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1L3Rlc3Rtb2RlLmMKQEAgLTEwNSw2
ICsxMDUsMTEgQEAKIAlpZiAocmV0KQogCQlnb3RvIG91dDsKIAorCWlmIChza2ItPmxlbiA8IE1U
NzkyNV9FVlRfUlNQX0xFTiArIDgpIHsKKwkJcmV0ID0gLUVJTlZBTDsKKwkJZ290byBvdXQ7CisJ
fQorCiAJbWVtY3B5KChjaGFyICopZXZ0X3Jlc3AsIChjaGFyICopc2tiLT5kYXRhICsgOCwgTVQ3
OTI1X0VWVF9SU1BfTEVOKTsKIAogb3V0Ogo=
--000000000000215cda064f3ddc2f--

