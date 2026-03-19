Return-Path: <linux-wireless+bounces-33486-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI2DGiQLvGkArgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33486-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 15:41:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AEC2CD091
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 15:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8CBF307A54C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5FC3BE649;
	Thu, 19 Mar 2026 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FupBwBCp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63F3D525C
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930964; cv=none; b=JbcIzRt9gtiiMutoYVKOzzNSxSiIdbFERyk69eC2R84MkkFuRsAFPq8idEr2Vjltj9UI3fDPhEqep+HVNfHy7/t7xArNH/+PpXYQfC5Uy9NKzuS8NNQLdheZ6wHMaRfo+yUf++UimR40xM64+H6o65IhnzW+VaCJYWouFmF1bFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930964; c=relaxed/simple;
	bh=zdn3ABybvOnUCX3SQqGwAZ9n01/Eo7wHFSko1qYkRZE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UdAIZpbPC4EDmJHRptqSEN/dFIyVxJZIl8g1rauo31yR4d9dXaJZeimmRXOAuuHhjpObZeS0OJX+1pLnW84VzAsTp9JjoTD/tS+qqIKj67Bzer2nNZGm1WInI2fB4jHSLfu66O7xCKMyzs+DJn8iu5xEB/05yGiCgP8AcytlV/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FupBwBCp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so9150115e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773930959; x=1774535759; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyR/DEKSshAx9ZjwsfQozRP2Lry/ms/E5lB9zjtmtnA=;
        b=FupBwBCpdGKcmmZIsDLeCR59845NxjWWFYya3OCfLLHW0ngX/mK3MaWuRuHTbiizGi
         m1nuvd0JPSb+kVVJfc1pGzdgDr4dpNXnIlBNDDOhyQJkyJ5nxOBXJLOInAg+Pj7vGVFK
         RTj/EJ3AJsBDtquRrUM3fwcnXHHj+TYrxknuqp9nV2VZU+f198QAZnFBIb1XWxA9JTBe
         BQWKWoPGrGYs2NwAsY6JGrW3vZwD6dOVdQULkJUFRXUMVRuGQYzEYfvCd3SW6axUxcDI
         inSY62DbX1ML7p1dpUvqLqD5uXA2jMa0QxpUQs6jYzTjmZrKu5hY06MAz4LcrOiKVWyX
         v0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930959; x=1774535759;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WyR/DEKSshAx9ZjwsfQozRP2Lry/ms/E5lB9zjtmtnA=;
        b=JyhlISH1TpmNqD3mqwYKAUY1gVQ7wh+YutQyn/Wc+bEGq5Y57RfD8djUJKh/Nvjo3V
         AsfH3dyGicPVNsbSEvPJui9ejfONJuWo125rJVWKWWYvt0dbYlSD55d/bMjrWd5+5YFv
         g/7L8ArPw8MQr2rGcVCrwvRyKPtajsqBQFxyuvOqcAlAfD35czJJqXJanQSIXuw2OZ4p
         zwXxwhNPf1vwEO8mTYr1zHA4EodwuXdPzWB0hDFZA1QSO47vXegYaJB5vCTSBMVJyWOP
         rKQ4PFavwi4jESaon8INrbHYIDr1iWf7BBMnw0Ibvj7sxk3YeLFdxlBiz4bNghhcbb3w
         jpQg==
X-Gm-Message-State: AOJu0Yy46vVHwuEmtguUOCCINYl5+OrW0FCWbA0BxtaKMLF+qy7Tt1r2
	68hRGQW5VaOwMOV5ejn96cx4sXv+i3+zH3zUjijuYyzp5lAthfxghEKXdjGtIg==
X-Gm-Gg: ATEYQzywkKzv9vkL5wDS7VUovGyF7z61hykLIDwdS/8aN3NNijBQqARlPjkOwnHNzi7
	XQYztOMjHc8wKIVr16t7Z91dB9wf/4n7anFCiVPTXiipzlQwcED9Qnv+kyQ5ZOgzMfv9EK/zHnv
	Ax4V90x2TyANf5Xad8HGDdYwOtfdEsxB+Sbxx5ek7qUOQBjurPsXXEX2Rr2wb4B3MPwg0VsLK4M
	wW364jghGBETTrOwJYk0qr1BgXvcWFMHObkIgdGND4VLcE2lOI3f7YEWGXUMz9bK/WaEoFB9Ob1
	Ohy/JeaDpbVwGCRw9XkMT3z8wD611CDV4AwE+uyHOHhuSNIDwa/I26NWX82tobXZJRYkmhJGpJk
	DgWI1P84L3ZF4l9XvqKh9544KGF+wyZ/F85ygh3aDQqdUXxz9Njbz1sJeqXBHJYqU2Vk+zhSheq
	iPR4QFzrODI2qinnmEX1VdMly0ZqpJQHRsi1r7x40FoRvhltNQVbsw
X-Received: by 2002:a05:600c:3e85:b0:486:f4d2:eac6 with SMTP id 5b1f17b1804b1-486f4d2eb2cmr104779845e9.13.1773930958452;
        Thu, 19 Mar 2026 07:35:58 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949a5sm65736155e9.11.2026.03.19.07.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 07:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 15:35:57 +0100
Message-Id: <DH6U1JMUQXVM.287BFERLLK9KK@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next v4] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Rameshkumar Sundaram" <rameshkumar.sundaram@oss.qualcomm.com>, "Nicolas
 Escande" <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317084740.3756880-1-nico.escande@gmail.com>
 <36c1cae8-d6c0-4432-bc8e-57216c5ea3fd@oss.qualcomm.com>
In-Reply-To: <36c1cae8-d6c0-4432-bc8e-57216c5ea3fd@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33486-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.948];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5AEC2CD091
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu Mar 19, 2026 at 12:08 PM CET, Rameshkumar Sundaram wrote:
>
> Since CONFIG_ATH12K is tristate, a built-in boot can continue past a=20
> failed ath12k_init() and still run ath12k_wifi7_init().
>
I genuinely thought the kernel prevented this. I was wrong.

> Please ensure that later initialization path is guarded against=20
> allocation failure.
>
I can add a flag like so to be able to check from ath12k_wifi7_init() if th=
e
init finished ok. Something in the lines of

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/=
ath/ath12k/core.c
index 6c034071cc6d..742fb33f41ff 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -34,6 +34,9 @@ module_param_named(ftm_mode, ath12k_ftm_mode, bool, 0444)=
;
 MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
 EXPORT_SYMBOL(ath12k_ftm_mode);
=20
+bool ath12k_init_ok =3D false;
+EXPORT_SYMBOL(ath12k_init_ok);
+
 /* protected with ath12k_hw_group_mutex */
 static struct list_head ath12k_hw_group_list =3D LIST_HEAD_INIT(ath12k_hw_=
group_list);
=20
@@ -2323,7 +2326,14 @@ struct ath12k_base *ath12k_core_alloc(struct device =
*dev, size_t priv_size,
=20
 static int ath12k_init(void)
 {
-	return ath12k_wmi_alloc();
+	int ret;
+
+	ret =3D ath12k_wmi_alloc();
+	if (ret)
+		return -ENOMEM;
+
+	ath12k_init_ok =3D true;
+	return 0;
 }
=20
 static void ath12k_exit(void)
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/=
ath/ath12k/core.h
index 59c193b24764..f35571b1a541 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -101,6 +101,8 @@ enum ath12k_crypt_mode {
 	ATH12K_CRYPT_MODE_SW,
 };
=20
+extern bool ath12k_init_ok;
+
 static inline enum wme_ac ath12k_tid_to_ac(u32 tid)
 {
 	return (((tid =3D=3D 0) || (tid =3D=3D 3)) ? WME_AC_BE :
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/core.c b/drivers/net/wir=
eless/ath/ath12k/wifi7/core.c
index a02c57acf137..542ec10fabf1 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/core.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/core.c
@@ -38,6 +38,9 @@ void ath12k_wifi7_arch_deinit(struct ath12k_base *ab)
=20
 static int ath12k_wifi7_init(void)
 {
+	if (!ath12k_init_ok)
+		return -ENOTSUPP;
+
 	ahb_err =3D ath12k_wifi7_ahb_init();
 	if (ahb_err)
 		pr_warn("Failed to initialize ath12k Wi-Fi 7 AHB device: %d\n",


I don't like it much but it is easy enough.
But I don't know if there is a more idiomatic way of doing things

> Or may be have this allocated on first device probe and free it on last=
=20
> device deinit ?

That seems even more involved. It would be easier to go back to the previou=
s
version and simply, alloc it once per ath12k_base

What do you guys think ?

