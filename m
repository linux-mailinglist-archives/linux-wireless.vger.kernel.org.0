Return-Path: <linux-wireless+bounces-29726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E675CBB3E5
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 21:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C609D3009AA0
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 20:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1E23D2B4;
	Sat, 13 Dec 2025 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA/BQv0z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7082356D9
	for <linux-wireless@vger.kernel.org>; Sat, 13 Dec 2025 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765658977; cv=none; b=VfNn4fgYda7KSvhxJ9enjKcc8YyFCnkS/HM+Mcbtx6C2muT3LE5ZqljcEJr2yIPnHTMS64ibTBlsy8ywjSF/4q8X+mB/PrOo5SCj01gZAuc8hH2miqg/peuCTXrJscrJhGkVSn9bYFMU0NLMq5jf2vNcgOH0bk4knjeXVzNkmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765658977; c=relaxed/simple;
	bh=aLoi7e39oZoF4myrCeK4XU6gPKjVw6dqMwm6IvTHI3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q88ZRC22mqLGp5yVBgs15KLW32X8sn7/8BBlLypZaIJmI8r7ejuyx+3CCbSXDdlBS/rGP4ZQXUKHBq9J6Ma3fMO1SiTgRNHJpoJXJtSU60HAqKL48/ar6Dxlb8C7rAdaCTaBYuVXwBGIMkM7ANPQvUNJm6LgB+I6+lAbbuhIO4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA/BQv0z; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78e7ba9fc29so2617777b3.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 Dec 2025 12:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765658975; x=1766263775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aLoi7e39oZoF4myrCeK4XU6gPKjVw6dqMwm6IvTHI3w=;
        b=FA/BQv0z0d3+gMGAWLIbvJ5HNKh+iUvE1rbRjB15u3a03hgiCKeoS+BK5dxC3q/jkR
         RR6li6ZEAqxnKNzU4z5/iZggOXzm38HD7MqNEGJpVoYnprp78vp6cVK8HmvRVbKc/H4j
         2T+/6PSyrsyZwFXQ9oxZefd4k2/Ic4zpS7aqD5M0JAyj8+N4in7XJG71VPpVy/+bGrXU
         6Z8b57jkCzAK4JJlzkHSGdVmySZ4gVox/kuI3n3VeeKpD4yHIwCpruwXPAvDduNO5c60
         8DMZmw9/7X/XlSGA8B9filu2Chg25D36TsixvrXdXZSmLuWex1ICDHD7yRlF29xYaHVa
         mY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765658975; x=1766263775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLoi7e39oZoF4myrCeK4XU6gPKjVw6dqMwm6IvTHI3w=;
        b=mOb7SFZIrJfB8bB/6c/+/yKtRysIFh7aFOONXcKPkdY0RRClSY761g/+o5HsXda7AV
         eBDUKV6+MLu7GLnByoZaAfjPenAS1TJtORXySjZysTNqbeFF0IPUpfOLIcPYj2FRXSNa
         r2WQrO5Em6Rjb0s9gizxeNl5J11rusCFIV4Pf+YaHMhBRAcXK5Ek+djs7Gb1v22/t4N9
         jvAk2/lHXaxWoSfaLkhdhSaLHi2mQiVuZo9lEFiPSIKOeqebBOMyXV/TPpHR8g8FM2d0
         mRbBRtL/IwXmrITsgoKee0L6vOlY7YGvMO81Qp65WXSsiZHXyGXNKEtm8Hvs2WtVWBP+
         bPXA==
X-Forwarded-Encrypted: i=1; AJvYcCXXf3iZlYgeBfstN9PyEa+0RWA1QJ4SOoBtAaoQc+r/qJllgIn74PisjuGYO5BQiF/o//owA5gsJjaXIjA3vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlzkTvTTWbcwfBdOpZRmdu/FntHQLhT7vE9RX38ckogEDO3hRq
	/htOmVBn4AuL6+21dkEmdNHbhUSj8hPf/G6GLfKoxZFFytmnmGKgmIjK76N2AB4bOp3HQ7i27lF
	SiisSQuC6yILX+TSss+bfQtP+fh1dMpg=
X-Gm-Gg: AY/fxX5101+ex5GuIaNnx+OW3EHDuwVcYndIAF0UYpCID98Ce7nImQ7kGvLAlZp9m0o
	O//+IBb79NmQ2ZkR5l+4fsbsYancx1v96fjVMHvKWWweeWDTvmGJ7bkR3W5DdApR3Pl16Eqhepr
	JSzc3xEyiSTRTi1PW7mD/s5n0Z+aWRdhIy1EesG8a2lIPfcJR8J8HYlqYwb3bYQ3kHEoVLfJeMG
	SawQ9J5JJk+QQvabeYD7E38jchg26uDriTs7gvVKI+K7/AMsd44cPIAUD5gZ3QryZid+HGgqd98
	i0w24tpzR6gi7QpH+6euIO+Pq/AS
X-Google-Smtp-Source: AGHT+IEkyyIDmXlMSlq4drtqGMchlvr2pM1cBYAqNht+NQuiAaDQQgsZEebPjeS4xuJXCwQgwseKhoH3Fx7vh3HmixI=
X-Received: by 2002:a05:690c:9a0e:b0:781:64f:2b63 with SMTP id
 00721157ae682-78e66ea4ad5mr57811437b3.63.1765658975277; Sat, 13 Dec 2025
 12:49:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1670e04b-9d61-4778-9d7d-e0d1c2ebb5f8@aegrel.ee> <e006938d308662f44b869d008a052546bff24b5c.camel@sipsolutions.net>
In-Reply-To: <e006938d308662f44b869d008a052546bff24b5c.camel@sipsolutions.net>
From: =?UTF-8?B?VGFhdmkgRW9tw6Rl?= <taavieomae@gmail.com>
Date: Sat, 13 Dec 2025 22:49:30 +0200
X-Gm-Features: AQt7F2rESjjWe60Yp64woOttoasTFst46-Dh20_GqOCTw1Zy287EmL6MP0IhMK0
Message-ID: <CALfTr+pMYvozUq+qVpy8zHS9rdQ88n=zcXCSBgThsOqf1JCOnQ@mail.gmail.com>
Subject: Re: [PATCH] iw: scan: Improved handling of Country String environment values
To: Johannes Berg <johannes@sipsolutions.net>
Cc: taaviw@aegrel.ee, linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000047ddc0645db841a"

--000000000000047ddc0645db841a
Content-Type: text/plain; charset="UTF-8"

Resending the patch with changes as an attachment to avoid email
client mangling using Gmail to prevent LKML+SpamHaus from rejecting
the email.

--000000000000047ddc0645db841a
Content-Type: application/x-patch; name="patch-1.patch"
Content-Disposition: attachment; filename="patch-1.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mj4rhkci0>
X-Attachment-Id: f_mj4rhkci0

RnJvbSBmZTk2NjAxNmE2NGFhYTFkYTljMGE0NDJkNzM2YzFkMDYwMTNiMzIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYWF2aSBFb23DpGUgPHRhYXZpd0BhZWdyZWwuZWU+CkRhdGU6
IFNhdCwgMTMgRGVjIDIwMjUgMjI6MDk6MzUgKzAyMDAKU3ViamVjdDogW1BBVENIXSBJbXByb3Zl
IGhhbmRsaW5nIG9mIENvdW50cnkgU3RyaW5nIGVudmlyb25tZW50IHZhbHVlcwoKVGhlIHRoaXJk
IG9jdGV0IGluIENvdW50cnkgU3RyaW5nIChkb3QxMUNvdW50cnlTdHJpbmcpIGNhbiBiZSBhIHJl
ZmVyZW5jZQp0byBvbmUgb2YgdGhlIHRhYmxlcyBkZWZpbmVkIGluIElFRUUgODAyLjExIEFubmV4
IEUuIFRoZSBoZXhhZGVjaW1hbCB2YWx1ZQpkaXJlY3RseSBjb3JyZXNwb25kcyB0byBhIHRhYmxl
IHdpdGggdGhlIHNhbWUgbnVtYmVyLgoKQWRkIGhhbmRsaW5nIGZvciAibm9uLWNvdW50cnkgZW50
aXR5IiBhbmQgaGV4YWRlY2ltYWwgcHJpbnRvdXQgb2YgYWxsCnZhbHVlcyBmb3IgZW5oYW5jZWQg
Y2xhcml0eS4KClNpZ25lZC1vZmYtYnk6IFRhYXZpIEVvbcOkZSA8dGFhdml3QGFlZ3JlbC5lZT4K
LS0tCiBzY2FuLmMgfCAxOCArKysrKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NjYW4uYyBiL3NjYW4u
YwppbmRleCBkZmMxMzZhLi4xZDdjMDU1IDEwMDY0NAotLS0gYS9zY2FuLmMKKysrIGIvc2Nhbi5j
CkBAIC02NTksMTAgKzY1OSwyNCBAQCBzdGF0aWMgY29uc3QgY2hhciAqY291bnRyeV9lbnZfc3Ry
KGNoYXIgZW52aXJvbm1lbnQpCiAJCXJldHVybiAiSW5kb29yIG9ubHkiOwogCWNhc2UgJ08nOgog
CQlyZXR1cm4gIk91dGRvb3Igb25seSI7CisJY2FzZSAnWCc6CisJCXJldHVybiAiTm9uLWNvdW50
cnkiOwogCWNhc2UgJyAnOgogCQlyZXR1cm4gIkluZG9vci9PdXRkb29yIjsKKwljYXNlIDB4MDE6
CisJCXJldHVybiAiT3BlcmF0aW5nIGNsYXNzZXMgdGFibGUgRS0xIChVbml0ZWQgU3RhdGVzKSI7
CisJY2FzZSAweDAyOgorCQlyZXR1cm4gIk9wZXJhdGluZyBjbGFzc2VzIHRhYmxlIEUtMiAoRXVy
b3BlKSI7CisJY2FzZSAweDAzOgorCQlyZXR1cm4gIk9wZXJhdGluZyBjbGFzc2VzIHRhYmxlIEUt
MyAoSmFwYW4pIjsKKwljYXNlIDB4MDQ6CisJCXJldHVybiAiT3BlcmF0aW5nIGNsYXNzZXMgdGFi
bGUgRS00IChHbG9iYWwpIjsKKwljYXNlIDB4MDU6CisJCXJldHVybiAiT3BlcmF0aW5nIGNsYXNz
ZXMgdGFibGUgRS01IChTMUcpIjsKKwljYXNlIDB4MDY6CisJCXJldHVybiAiT3BlcmF0aW5nIGNs
YXNzZXMgdGFibGUgRS02IChDaGluYSkiOwogCWRlZmF1bHQ6Ci0JCXJldHVybiAiYm9ndXMiOwor
CQlyZXR1cm4gIkJvZ3VzIjsKIAl9CiB9CiAKQEAgLTY3MSw3ICs2ODUsNyBAQCBzdGF0aWMgdm9p
ZCBwcmludF9jb3VudHJ5KGNvbnN0IHVpbnQ4X3QgdHlwZSwgdWludDhfdCBsZW4sIGNvbnN0IHVp
bnQ4X3QgKmRhdGEsCiB7CiAJcHJpbnRmKCIgJS4qcyIsIDIsIGRhdGEpOwogCi0JcHJpbnRmKCJc
dEVudmlyb25tZW50OiAlc1xuIiwgY291bnRyeV9lbnZfc3RyKGRhdGFbMl0pKTsKKwlwcmludGYo
Ilx0RW52aXJvbm1lbnQ6ICVzICglIy4yeClcbiIsIGNvdW50cnlfZW52X3N0cihkYXRhWzJdKSwg
ZGF0YVsyXSk7CiAKIAlkYXRhICs9IDM7CiAJbGVuIC09IDM7Ci0tIAoyLjUxLjAKCg==
--000000000000047ddc0645db841a--

