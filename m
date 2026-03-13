Return-Path: <linux-wireless+bounces-33211-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKstCUEPtGlvfwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33211-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:21:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B910B283A8E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9F4328952E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03E34751C;
	Fri, 13 Mar 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="TdlnnDZn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8B318121;
	Fri, 13 Mar 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407963; cv=none; b=FTH6YoAhR4y3eylmfuxgC/Kmihbzg6hK7BUpOM/YHddUJhMBnNMVAAjY9Q8G6alkwahZc9Ir8abX+/57jq2G9vH6xP3NySTz5RsI7wU+aQQSl231P7Am9N/30d6xnu5n8Rqs8UNDaN/YqVl2uNe/4o0RPvFEW/YUSWuz4edWMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407963; c=relaxed/simple;
	bh=+x1gvG4OOMHETI+QegTRdkd25K3zqDwT7VwKdtHfVms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRICogSaN9lY6Q0hD/4CpDPmiDdmhyVvh9LTSLAb03fWWRchWSBlt+HNd/j5FUElD7FPhaZE2u16BYhx+7OmM51AmtCs0W/iGUlMqlE4J685ypZCFF1nvOBQrN0GC3MRanxpdyfF60EYWgwPpkdPM1sWYgAJIxmo2uTGAIBokYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=TdlnnDZn; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773407959; x=1774012759; i=georgmueller@gmx.net;
	bh=fo2jxlDNyILdeYr6pOtkFYzidNRUklP7RSnQh1fC55Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TdlnnDZnB8mW8ttNRRst5x5bjrmx9DhjMTtVSy9dt5WsbUdfOMuRoIZ3lh2Ja6WD
	 Cc/ufpwPjvf0z6aR1/FQ734lTKH6xplwwTCG0trBqZmc30CpNzk0UfhGGSuS6GUMA
	 VpHEMuGkoqY97M8ogsNYBAyAh15+Li0iNSIt+Cl2a9sTDRif+S3CUMgm+8U0AOUMV
	 8/ukTGlqSnDxxof9gO1jXEeHgPWGQbg2Q7rjreC/COuxY8/4OHsSqB/XkiSEyRS8q
	 sxmDFo5RDctjZd5cB4csroQTRgmb4OYJT+1uelDzYhap82HTiSblTc3JoW3DW2jFD
	 tFe1WSUbLEPB7vtSlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1wFxRB23UU-00Omha; Fri, 13
 Mar 2026 14:19:19 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH v2 2/4] wifi: rtl8xxxu: handle rate control for 8188e a per mac_id
Date: Fri, 13 Mar 2026 14:18:47 +0100
Message-ID: <20260313131849.3148013-3-georgmueller@gmx.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313131849.3148013-1-georgmueller@gmx.net>
References: <20260313131849.3148013-1-georgmueller@gmx.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nwssWfdyqOrCDX8uzhuoCHMSjmLazdeO92P5YShInAZnvstg4sF
 wuS1kidU8UTPWVhecZLnD9pH/LREdggBKPGTwYfXCdmdKrYRpea2VEn7mOU2osAsPxgv5gV
 Y37g687P06E4xwRrAIPAuHI0cnHWVH/wsi6zblPgXGTKjvVYz4w+DMoJuVHd4JSOqOveoHM
 v2q7/0VPUGjVmMuG5cX8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fL1z0GVRb4Q=;xmLf+4ItOsEqdOegHeGm5/OhdPO
 sxC4IKn0awZ80DNOPLztS6vqRfMGFAI2HdWhmT+X/sjON7xDTfj4u5/3LI7ZfXK9IwieiahWn
 lmSd5oVUCGsAq+I4tiTdL2GNGUFjC7PBo2zleyzNl4HJ9imjITf1gCt797SJhXZC5movJnlqR
 GhEBTBpmXoTNTmxwdlTVMUWBcu1pUz/rqu9obuuA8No0p8SurKq6qf/BTe8sUQLOdXNJji2En
 WIq+WX5miT8SjFylkrxBih05yUKTY3uoeree28gj2F693owzVSscSCnMBw2/uH0kQV7m1GulT
 Skevgs5oUelD47gNqPlxjgsBy9iZ4CsrD50keC7eQWCQ/rcTt917aXNOtljn16qVutTRPQPJ7
 Ekd0fjlNVC2339qQhN4Qplx2EM/fQRu34+TRcvujEHJm2obdMT2sPeZ5+Kj0o01XMyNutPfA3
 nxmmZTo8u76s5AaHDs9oJBBFAkMDw/SRJLcy6+KSqxLHn/u6zb3nQzfH5LTD5nhIF+9ib4ybp
 oqCRbaFlt9MFMqP8w5NWxlxW0PsCHC4YLgB339RClQOVzJH/VAedzhKNaaBLbtEtjd612wT7p
 MbEuUFcNuN71AKSJrIXZnx31ML9zwhI32IwjMghATJknR1Kx+QqzpSd0TJBP+KeioehuqReB7
 W72PsIeZz2avVWuRfJYaRklzBbqjFXClYWF8wxB7S+tOITByXSxfRewb7q3vTq4+sSJIW90Vk
 XFgL8BZ4zHhlQNFL+cmECFbpGBhIlRN5Bz+Sdv7+6zhu+CyVzHukawnxLrlCmRhiMkE4xOG8Y
 sfTWy8aPdb28ybSVJII10yRtnM0q+HtbKQeBDq3tKj30YkiY5Sqv5CNhXshabXOFPTALN2mlu
 ZuIwMZDiHDSL3MngOMk5HQaxRJM5ZGzmsy+pDwFvXPqgTkIx8pUHw+VCuBpVfQkm00Gv1t4RN
 QwhCZld3FmjBGQ5UPBhrL8yNsW+mH+Lvi6I02hwT7jrk7RiUh2mAw0czT1kbbrAv38NLFdjdC
 u7Kekvw+HosY3mtdkhca/1WlI9b2HwJgzvdjNpiPQJG3C7jVc497fD4ofHfcH7KM4a0sQlQed
 fEG0r/M8VHevSvBjbI4+ac7zaXPpKNYagS7tHz38L6bM7k6RdlkPiitldxmoIHzCpqWfSWPkp
 tdSMPpbo9idIszgy0WwGDOhAcjVSHBFFar/odN2j88651pnOsOND7ySb398RqaxSdVFUxjTaK
 TQ/EHQuNy+w0zrKzugoCLJ5O+aGZGoHa+rsGBN7asm9Zkv/ypn4OtWPP44NQdxTMf03vWNtRy
 YOCkBTmcTsGJ412lz7LrlrAhq1TRRx1RLkpKpyNtDuL4UJeQg4B5O72ggdYKtUuSXOOG/IUyq
 29Tt0rWsPjx/jOQwLOhP4W+g3P/ZioLh+rWNXBBkLnKUItu4UTwB+pTPJu/KhR39yV7ek4RUE
 PJ9H7KTyNSNQbRilsIoFx9MvBxhx5Khd5bVuRNemy9ZirixWlZIN8Qaf7XswaUtADj5nuSvZ0
 bCAADw7QNrwQOgwtLoyknWysB+FRhLyY6fJG5jCCrSM/JaTgy9k9zg++gcY1Ng3SPK3eysTnH
 IyLlpv7Mv9MzKFmiuUkfyHPrFblJ2U/RlhK8tKbAqs3cj+JmbOoMx074B66M80CkVpPsMKsoT
 GfJ7V06iIaRSLMoXGNrNro5az4QL+r+B485kmTiU1dgGeHi1wnQ1ffG1YsHotHg/TJbZWKYKK
 FSRCFMSt4767698C7yGvYZdL05odMLDupgE0dY4gFmkDGYPXQINV46T2IudEDcAO1sMnP3J5M
 GBFD3ZOIZc5IYV2Ew6p0H/fMo2IVPRDZHIngzr5iHdnQwAVZLyWq4qFvv0JABSHiByo6g4d/Q
 ep4aAv8dRGgESx2t1VB2ttT96SM8J0zoXF8E8DiKBosNwsDaVQ/IfLD+8M6Www6W/OvqXeqnQ
 7JgiCDid4ER1rwpK11TKCEqw3goif7I1/GW9Oz0l8C6qt5/V3PB0HKhk/JiNbARs1Xna0xTIm
 0WhE+iURzaaEjAu9ujpbc1n1T5ES4iojUVxZY2R5VttTCOviGkpMETv48GRKpNHm4wSIo3Fda
 vxuHwfgN8FO7HGjYuApw49Q+WoM6NyCpNvmg6qVyPKkRrHD05CSmbYzb++Z/Qe/LPer/g1jmH
 MKcRN3LFd6/+xA4AaFQoZlZc7j+2J+fdTk4aBwI3OptWFmuI/a1LCrKCE1pcXF8XhWDn2zRPn
 hH8M4e/1xxcrEEDxHClFkRhWQWCR6EnSo5b6AklPJtgG7gMvJ+7SgDa8JqEslPUjHKsTzpj0d
 Qkzj6GQfzt+bF765KVUbPJkVGOnKPAQK1sXc0s5Gzrbl+f9+FrYzIm2ItYgjG1KcQpGAXPWzw
 A6Mr4kprXLpKtEK+zhuguMlRUdccq3qMHOez3kcjxcZdKYDPgi4hUwCy0+o75Wg2PO0TJa7VE
 w0BsCDQybomwJUjN2lBqK1b8gQ5+VNsknAKFkxouNs8HXk8eOHH2MoyD/HsBD45fILSUTSBmO
 RBt1t48l1OPoKVwOGTNKIMGUuKNp903SinAQwUNHdxO4eF785kGbRzPzN065s8IIGS10x9A6u
 RnTfH9reUywQZqf32Loi+EwxpWkf7+6f1hELNChNIn/aIHjQOSXTCgwlC0jSmsYURLrBn7YV2
 UhnRN+PZRQWG9Nxo9rVDtZxtiBZ5EoSMtj3Zu5N80nKR1lFiIluvnMFiTMlZGASaJ9QdBAXTp
 KCrbkAyhL6vLIE88eNVwp2ujWhjzdY4dFsKlVF0qj4BPt1wptjnfuaHSGridP3Z0eG9O/f0US
 Tcik5ma+pKW+pAoIOsYTbtx+nR+7nSsyBPB0su+GjJrJ5+clTbzDs6nhFHR+TT7Md1p9/hhJc
 f0Lsomes3m8qdDf+NFJ8vLLX6DRImrnRxH0m9GVN8AxGJIRh+O9xHAwvc21iNe62s7kCoCIUm
 bTYPDLReWKQaeNrKbrmHncR8hD1NFbWFC9XsYb5hHnF7hQTD0BwnTIYogaHzvhAglkVz33Pr3
 8julZjm3ieCNA013oueLQlinRpx5YevFk3MNXmWqrgvHTksnSNo4qcAsTRmxuf6fLzqHVd8pW
 lJwBzvvC8lzds+CZUjA2keC4zzdyNif28T4udYAoPTAzOY60niXusR2bEzv2Z/rgChVbIkOi0
 jtEGhP8W30tAMcWDjtwFBjiFD57w7KIk9CtrUpwD4qI+LQbRSjG2VXLU/Ny01wfn0tZp8xdBc
 dVk0aGnmpCuBvXBTA7UKGHt4cMfYseUJ0h2YwYL2+kBDTnkCmv6tlZhkWDuek64sZFvFcT6VK
 ouVyc2vyJtVC9pZAM5glB3WfbPoBkQkhWAvgGiJwxRacqaPmp9kZP114+J9fDq3tF4qrdYbuh
 oU0vsPoxtpvnmX3GK5lM4T9gMgFXq9INFPVGGhI7UeXX4/abnJgrxDJWA+pN6NjA6syFdPWRv
 wFh+v1O6NumKgRiCyUHHrsbnQiC8VX2XioKu1Vm1sazlE9K7F+r6/q6iuJZ/5KnYuPAFjOXXT
 Pcdihld6YNhOcEXj2XusBEvJZJpZP/G1vnhpoQP2ItMMVvLtz2oI5DRjJIy03BFY3ZLxHbxva
 Ysb06QS+CipugnnC0yBp6cZOgsD3tgGcd6bJP748+9iC4ee3rMzKkmkqv1LMInmfKBL1UXVqW
 sNZQ3dpmNJwzQHVZPTjpH3dZrFPf3XPZcIw23sJcoDbqbdCYBh6/UX55CYzosJBGnIif8EYMF
 ipB5G74jOrxMRWI9bvcOVHbyPoLiqBfnk8+kBhxmA18BFkqO9N8Swv4LM9a0A+qNUHCBCYlMd
 e+EPgsG26RdAaInsGhUa/TbIK+7dI7U2f0zKenu70NNg2zxXkD56/ZfnGk1MCWZnaNut8n1f+
 FHWXJ0NdVtlJbs9QkJpmDX3SV+8Z7lW+qjDF+WckCkogM+ZePk9nWHaF23836uwlnF2QCdvWy
 PLlyQgQ1LQXab/TDz9esTTicUWEStA/9JrsyS8zEAfWOef4litTbOFwsG9uNPPzhN/WafNnKy
 17PlNq7n+0oThnvdjf4YY6fs5fzaG3dmDvfj8C3mAq8t9q/OJ9uR54oRsdKPRq1k2V4fvQIed
 IIHMv6yrAJ8bEWkRSzn34hm3GISW4uC+R/lTJMBmWKMqRs2iPZRqQJv0Wg96q0dX4D8D5Det+
 4j1VzxltXIdlcDid5TRi9yG7X7bmiiYZYMLJkVBT67oM4nsUD7r4u0ZYDLBlVkoeBG7ZoMy7U
 4fSJceRNnwaFILWerCl+qD4q3jgxcUTG0BWxa9ZOwN4A9eWW2uBjJ+R5W0BijX1OHkBors8Ty
 oPHX/jYIL4ffFCg6ZQDEAxAvumoB5Wc4c07Le8fTVCe3N467d6qkUYFwe7QKhYKLeyi2B8dgy
 w38OhfYoffRUOZVU9xasGpj/bi5+KEvDxOotmc1OVcWKtRUaeZNwvcrJFuOwx9dgWq0GXRxL3
 3kSDrnCXpMeOVVOIQ+XfIJuTh0xXO1kcqa79Pl5y0uhmVEI35zU6mRyTd975IELHUhrnovVH9
 CfiyXKv9cg4V/zQ2rNSwu7aeLHIAkCWBrjhb46zwFEl/CxatYUzRSsbs4Le9o/Fs/wvHnqwkl
 DbxEs69ZKbT3uVSRG18i+sy/4xB1UjKWdu648I2wMXGZBFD45Otci/FFAeYI/i3SvBG54Mb7A
 fcLXARi0bkdj+QOdtjIQi47c4tESwZHN7CJ8v7JrIcO2ibJNYQJXxIzqYxOpiJ3D0S3cmOMQb
 obhmGSqRJYCE1iDWenLPisMZIlLLlI1gVpBxA0FnQ78LENHVtsJoJxijNgrW8hTKA1UmMEf76
 hh7HOi5AVf74PzMCA0kBHXyScE9zC/UaIWg9Regb/NoiLKLj3z84EWTW7RiMax73QH9jAuvFb
 9UllvZGc9emKCk63VsOZeY2OTP6KCdev/qi4eexu74+lZiH2jzARMHKW0irA8hbwVKuvM7D+j
 3GmVQ6Q/dq6zjIiEhBHuWxXiG0XKzMiylCCxbrord8QfEqHZcV0Q7oMh1nDTSdJrjQc+r33Mc
 yQT/LlYFB1ScLLAmZDC9OXllpxQs2RfK6Wi9dSCfG4P/kheWLrCtOPRUXfwM4YkQvj/76E5/K
 vKqr1+EIBq3HVd58qfTR/m+pFGIKtggYqA+kJypSO5SezFPqN9ru0dRiNTDCgYx9TjN1PTeyI
 BUXNcKnsVyk1l4VsYeKNBBqGI0O5gJSyGuvmVjwmZZehGdgMBXNYc9vk4lV72NTwSMio6VR4F
 An4DenHEtwd1dE78VcYTzHKmyIuFgpDFZrgDTklrvpxieC7e80CxbRDhyR3zCYm1/pJg4k6xE
 KiFeOQuciY1426n5W/6t2C++lMPkKB39w==
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33211-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B910B283A8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

convert member ra_info to an array with one entry per mac id. This
allows having different rate control settings per connected station
in ap mode.

The max_macid_num is conservative. The old driver used 32 [1], some
other sources said 64 [2]. I have not enough adapters to test any of the
higher values. Given the usage of this chipset in nano dongles, I think
the 16 might be high enough.

[1] https://github.com/lwfinger/rtl8188eu/blob/f5d1c8df2e2d8b217ea0113bf2c=
f3e37df8cb716/include/sta_info.h#L28
[2] https://lore.kernel.org/linux-wireless/27e83382-4c84-1841-c428-d1e5143=
ea20c@gmail.com/

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
=2D--
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 12 ++++++------
 drivers/net/wireless/realtek/rtl8xxxu/core.c  | 19 ++++++++++++++-----
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 ++-
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/w=
ireless/realtek/rtl8xxxu/8188e.c
index de2837a91bbe..607ca62194fc 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1468,9 +1468,8 @@ static void rtl8188e_reset_ra_counter(struct rtl8xxx=
u_ra_info *ra)
 	ra->nsc_down =3D (n_threshold_high[rate_id] + n_threshold_low[rate_id]) =
>> 1;
 }
=20
-static void rtl8188e_rate_decision(struct rtl8xxxu_ra_info *ra)
+static void rtl8188e_rate_decision(struct rtl8xxxu_priv *priv, struct rtl=
8xxxu_ra_info *ra)
 {
-	struct rtl8xxxu_priv *priv =3D container_of(ra, struct rtl8xxxu_priv, ra=
_info);
 	const u8 *retry_penalty_idx_0;
 	const u8 *retry_penalty_idx_1;
 	const u8 *retry_penalty_up_idx;
@@ -1669,7 +1668,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_p=
riv *priv, struct sk_buff *s
 	u32 *_rx_desc =3D (u32 *)(skb->data - sizeof(struct rtl8xxxu_rxdesc16));
 	struct rtl8xxxu_rxdesc16 *rx_desc =3D (struct rtl8xxxu_rxdesc16 *)_rx_de=
sc;
 	struct device *dev =3D &priv->udev->dev;
-	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
+	struct rtl8xxxu_ra_info *ra;
 	u32 tx_rpt_len =3D rx_desc->pktlen & 0x3ff;
 	u32 items =3D tx_rpt_len / TX_RPT2_ITEM_SIZE;
 	u64 macid_valid =3D ((u64)_rx_desc[5] << 32) | _rx_desc[4];
@@ -1688,6 +1687,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_p=
riv *priv, struct sk_buff *s
=20
 	for (macid =3D 0; macid < items; macid++) {
 		valid =3D false;
+		ra =3D &priv->ra_info[macid];
=20
 		if (macid < 64)
 			valid =3D macid_valid & BIT(macid);
@@ -1704,7 +1704,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_p=
riv *priv, struct sk_buff *s
=20
 			if (ra->total > 0) {
 				if (ra->ra_stage < 5)
-					rtl8188e_rate_decision(ra);
+					rtl8188e_rate_decision(priv, ra);
 				else if (ra->ra_stage =3D=3D 5)
 					rtl8188e_power_training_try_state(ra);
 				else /* ra->ra_stage =3D=3D 6 */
@@ -1781,7 +1781,7 @@ rtl8188e_update_rate_mask(struct rtl8xxxu_priv *priv=
,
 			  u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
 			  u8 macid)
 {
-	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
+	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info[macid];
=20
 	ra->rate_id =3D rateid;
 	ra->rate_mask =3D ramask;
@@ -1792,7 +1792,7 @@ rtl8188e_update_rate_mask(struct rtl8xxxu_priv *priv=
,
=20
 static void rtl8188e_ra_set_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8=
 rssi)
 {
-	priv->ra_info.rssi_sta_ra =3D rssi;
+	priv->ra_info[macid].rssi_sta_ra =3D rssi;
 }
=20
 void rtl8188e_ra_info_init_all(struct rtl8xxxu_ra_info *ra)
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wi=
reless/realtek/rtl8xxxu/core.c
index 794187d28caa..ea4dcca9d22a 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -3921,6 +3921,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw =
*hw)
 	struct device *dev =3D &priv->udev->dev;
 	struct rtl8xxxu_fileops *fops =3D priv->fops;
 	bool macpower;
+	u16 mac_id;
 	int ret;
 	u8 val8;
 	u16 val16;
@@ -4393,9 +4394,16 @@ static int rtl8xxxu_init_device(struct ieee80211_hw=
 *hw)
 		priv->cfo_tracking.crystal_cap =3D priv->default_crystal_cap;
 	}
=20
-	if (priv->rtl_chip =3D=3D RTL8188E)
-		rtl8188e_ra_info_init_all(&priv->ra_info);
-
+	if (priv->rtl_chip =3D=3D RTL8188E)	{
+		priv->ra_info =3D kmalloc_array(RTL8188E_MAX_MAC_ID_NUM, sizeof(*priv->=
ra_info));
+		if (!priv->ra_info) {
+			ret =3D -ENOMEM;
+			goto exit;
+		}
+		for (mac_id =3D 0; mac_id < RTL8188E_MAX_MAC_ID_NUM; mac_id++) {
+			rtl8188e_ra_info_init_all(&priv->ra_info[mac_id]);
+		}
+	}
 	set_bit(RTL8XXXU_BC_MC_MACID, priv->mac_id_map);
 	set_bit(RTL8XXXU_BC_MC_MACID1, priv->mac_id_map);
=20
@@ -5338,7 +5346,7 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, str=
uct ieee80211_hdr *hdr,
 {
 	struct rtl8xxxu_priv *priv =3D hw->priv;
 	struct device *dev =3D &priv->udev->dev;
-	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
+	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info[macid];
 	u8 *qc =3D ieee80211_get_qos_ctl(hdr);
 	u8 tid =3D qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate =3D 0;
@@ -7895,6 +7903,7 @@ static int rtl8xxxu_probe(struct usb_interface *inte=
rface,
 err_set_intfdata:
 	usb_set_intfdata(interface, NULL);
=20
+	kfree(priv->ra_info);
 	kfree(priv->fw_data);
 	mutex_destroy(&priv->usb_buf_mutex);
 	mutex_destroy(&priv->syson_indirect_access_mutex);
@@ -7924,7 +7933,7 @@ static void rtl8xxxu_disconnect(struct usb_interface=
 *interface)
 	usb_set_intfdata(interface, NULL);
=20
 	dev_info(&priv->udev->dev, "disconnecting\n");
-
+	kfree(priv->ra_info);
 	kfree(priv->fw_data);
 	mutex_destroy(&priv->usb_buf_mutex);
 	mutex_destroy(&priv->syson_indirect_access_mutex);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/ne=
t/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 4a744b5c1aec..9ce820ff4793 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -76,6 +76,7 @@
 #define RTL_FW_PAGE_SIZE		4096
 #define RTL8XXXU_FIRMWARE_POLL_MAX	1000
=20
+#define RTL8188E_MAX_MAC_ID_NUM		16
 #define RTL8723A_CHANNEL_GROUPS		3
 #define RTL8723A_MAX_RF_PATHS		2
 #define RTL8723B_CHANNEL_GROUPS		6
@@ -1915,7 +1916,7 @@ struct rtl8xxxu_priv {
 	struct rtl8xxxu_btcoex bt_coex;
 	struct rtl8xxxu_ra_report ra_report;
 	struct rtl8xxxu_cfo_tracking cfo_tracking;
-	struct rtl8xxxu_ra_info ra_info;
+	struct rtl8xxxu_ra_info *ra_info;
 	u8 dynamic_tx_rpt_timing_counter; // 8188e specific
=20
 	bool led_registered;
=2D-=20
2.53.0


