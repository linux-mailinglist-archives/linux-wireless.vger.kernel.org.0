Return-Path: <linux-wireless+bounces-35940-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O4eJC4f+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35940-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:47:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBA94D19BB
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD520308FBFF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CE849252A;
	Tue,  5 May 2026 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IQqsHMQd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic305-47.consmr.mail.gq1.yahoo.com (sonic305-47.consmr.mail.gq1.yahoo.com [98.137.64.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3649251B
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999531; cv=none; b=TXW9Wyt7SwCUcg0yO9/cRYgeunRnmOeUs4TXf7pqNJ+zwXN0KYsGmTqj3cm8Ssr9CVR2FSdahI14ah/gwB7B7n7t0m2i4/b3o/SzgIVQ48IRcBtJufFpvWOj2kvDEgU/t8QdJ0DtG2ZRZEs6ic0rZGJHMVyypMS3E2uMMTo/ANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999531; c=relaxed/simple;
	bh=TLTB6rwu4EfIeRtKRfcH9Oe/xxrK0nR3W/sBT6/FNoA=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=Q7P2CrioSL2B8b5IeluW7Tup4rKEmzU4+ftfsDI0p1xBSK8r2WIDw7qzIZ2+iTDMZV3oh2jOs2aGUMs6RYcWpPgk45Bt1DxjnIhAir1WQSo4LHYD/EbrTK9l49ERh5J5wm8Hmmb3W7dqbcMm3D1cz8yk0F+O5cVSe6JLhSBgZn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IQqsHMQd; arc=none smtp.client-ip=98.137.64.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777999528; bh=dJYsmxjIMaaBbfRcJMffADZ+EwXODNxF2nGiL8e/ML8=; h=Date:From:Reply-To:To:Cc:Subject:References:From:Subject:Reply-To; b=IQqsHMQd6ww0KuO0vDD2AxVh0BjrvmWP5jSAOcoQ1gau3oGNzF2uvkcvIDLTMCY5ZOi+9/M9lQwhVvhh6LhA8g1wPK+6prj6BVkp8x7rbVRYTjcnFYXCY9FZuBwhBvBdY40Nj9QVVka0q5NzCvwKzNdT8v/PzKpu4znGpHxkvQLgytkIZVLuiBXJZs8BlLEZez/ZDjHFKuBVk72Go6RdBwy54d2dMp4AoOnbUWAVJjMevHBuZI7NFZKvZUxyrnQuEdackfqT7Ng1saKr9nWsR0K9dyA6ntiBLpfMj/JczBvHQc/3wa/5z0vb8HG3jpPdxCYCaPQuM+yK/CD89/9BxA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777999528; bh=6D8p+dAhcD/19OXKSb6ufDwY3omMl+C/xQsdMT8eBco=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=j5hZP0COAm5OvbddfA3w3YXxmxwJkx9MgHaeDNIfDcA5YMwuhN4CoDUykXFcat8p95AUG/kjU/cvQ18yqnaEs+Feva4+bQJa1fixBRuAV5BI7mJZcOx5hHNcwFWjx6+2DtrS2INtVsbBbQbJ7aW7+msEaA5wcOmxZ7h5lJVgMiWFnGcWVi8DAzwUu/eU5WNbZLh46rUWh2EX7dtZjpRpjhRq5moPfrW56+Ojv5ODGQADVO/7SMYgtU3xGnE3LBSgKlyh2SVNy3Dg7hxyuTadC+cOv6i57ATY/3sCY8Am17NkYzyBEYfC73tmnjE7FqYazcyiVn0eW0vI43pChGirkQ==
X-YMail-OSG: ltNBEtMVM1lC97iaTlEtBMkBc.QYU.2E7.BVkL81QOtD.mixMYPaApJvKXiugWQ
 SzcPiShhMs9YQSORVS7HmoWFfnUefPNoq7NJHo6NMwQcmDaS8pstz3JftxYedEDqOgkGpjqzFTkL
 x2it_LTQviaTa0kFCr61SsWSI4I.R9NuArG0XxGoIiauDo6tNuoRT.O3BiCNLSQSYWiUtAIMgSKL
 XV9BDYgLENKTWkKRgU_xzdfJiAPQgcsMRkxiE82MmyEIOtI09fPUVRgXd6Y6lUrfivnNqzHn2OmT
 rgV7v7oZL5fHq1pZ8ciDWhmagoWQB.ndbZveCFsvZKRvJrMpU0SJILmgctZBopo9X0q8yuzk1ak1
 ajvI69PH2insUYiBJWxnMOHJQ9F7Zg5JfymOV_p7Ga33FvNgCTMDqTk6VCclklp7KMLm.VsGeJyN
 pP4wRiZRxiLzch5OJD.ntgDgket5W8AEr4_aA396rjZlT7Lv7c45Xh4fxrZLLKhhgjJitVpWoT3w
 .rXNIQpLJKR0jNm7WZynvoqcIJBzG9JrOVccggXy5ZOmi1IKF.PFp8MM9a7Lno5dsSTjrBNIHVyz
 CeOu8d8MahaE4EhkMunJi5rkyjHN.BZpdqBhwz2BpC7xVeWZ8WiMJHfDxmk.VOHAI6S.rbKb2bXs
 oamONCTHEoijRsC5aBtsQdTPK_LCRB3fCxpvMvmtnV.nia_ZN927fqjslfjjNK1a68FwDUtBRR8x
 wS3BgkIgGegysCBxQPoTLCviX2CXPd8Y80N2AFLgGRIrGp6emjlGgRoYkHynHqgpoC0PC44RHfgr
 TsW21ye63vdFqQaZ6sPVLbJl0yrFa3DaNJFq8GFJ5G592R4RKXtHQK6pQJhF6D4OB9afN.XpKf0a
 5b2uIK1mQ7gfH6mY9CBWnraSIoyxiVDohqDKkCn2BaKlS2pm12BVYO2dnXdHHaB8QpDrNdciFiy9
 LzI1Qmzc7xd0kdEtZQ1Tye89yumWO0WgyXGNPn7pn9QnEazVA0qDj5i3dQEZBnWZnBzLIKDD3xx8
 mwNZ8zTNkGSirwpdmTZL.EpZbymZ2I7vxf0GDkiWuBxNSL.rjsvk.j6ZVVP6mmVYLab30uFOt6ao
 N.WzIirOHtTkIprsZilu3_5YDjwaW7o9ayG_uTl0hdFK5e1rGUm50THj_IrE0l.uCUgEpRmsfQC.
 jTWn4yc.9JOkUVTR2EaJWV4bE6GIeFipeg3j0ngABQGdhYi6tWwb2N6S4yCix7p8hGKvaN1GU7A1
 fm1.v2KcinJIhL316sXEVA6NOlYgeZqyVj_r3_epF.ociUbs1IEMgBMlQHnaDaGT9ZtlkBJOFVva
 NE3cztBy5lzW6iqPfhOdDAxWcU3WOLiwXSl4QYK5NAb0UvNCV2Wr1hNs0bLPlxrUutYDmImwAB0X
 BbB98RKyTt.S1O11WXPBcLypKnPEPAzqRbvU1JPMA5kv6MIK8y8GcM3dPufm3oF8yB0XvdiChfk7
 dxFS18t9gnEfpD3MN_m1ah0_ViozUU_0CRLRuLn1Khqg0BeENSPIHZag4ymm7mcFYYqHodW216Mf
 a.spS_3EUQ5mhO3CtdMDhJoeXrKmF5VtcoQWv2SiJ3s56AY48bvPBjfcv_u7lUOK_QSh8bQGjBz4
 ME7q1WWbQlx_0UYicmSnFOYxZlpjE__U0XKnwZyD9lEvwT32Lvmc1ZA1M0hNs6ob0._oCieq4r5a
 gWIZ9B2EazbpuB6zfqyXJkaX34OXTxnWybGBzbuCK24jC5T1MLRegJ2dRXaJvGKTh__KC4WGFg0E
 5_XChfLDkk88Rg0IH364IHnfbD8x5isL5AKtsYBMKkKQ9FThB6psaad03OtaEK3N7uuCd2NSdQMC
 ozJQeSf_Pn55FqpBBuTbQ_6NskdH5M5uSyTUNtUbCqa6wcBmusUm22QXIiNXnyG_cgMCOmkwqkmQ
 dDv06gQf22HxpOMEVJ0VKb4lONGE4H9x_NSg365Pi0u9ONOv88cIvVOh0YqmbiR6f9OKV788ABhR
 p3EzSs_CGXEOawXIvF95hIFIYkAw5i5vZLL_WZtGyYB8wKr8hDkAnZ9dYh..8uYjE1VK0c8Y4qXI
 95C.L366J1b7N9nNS7qtYVIeBq0auJ4pFW0Q5knZSaKSncihpeQllmy3cr74obmn6ule3ejYv2GG
 a8CNyQiMIWT1E9vfUearfejAJHUTYEw0iPjqJL5ov__gu5sKKLm9.9ROUeBU7cjkd2aWF00d72bF
 gsEYF9SV..lf9n3UYb9qP_VJF4YbKScJIs.RfA6NLiYOP3LQfXIGdSkxVbcxr52j0wxX7avCaDen
 3TB4LICroVUnhO6XjTni7FCWv5MiFC0jPF9YKUnqrGw9ZIdsNJFfKIGLTA8aQNHsK_revwt4ooJ.
 ogK29.H5FlFbqWbDdbSPz41s4h9ty
X-Sonic-MF: <mnew_iraq@yahoo.com>
X-Sonic-ID: 41a112da-b0e4-44c0-8a5e-ea290337469d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Tue, 5 May 2026 16:45:28 +0000
Date: Tue, 5 May 2026 16:12:11 +0000 (UTC)
From: Mohammed Abdalla <mnew_iraq@yahoo.com>
Reply-To: Mohammed Abdalla <mnew_iraq@yahoo.com>
To: 
	"wireless-regdb@lists.infradead.org" <wireless-regdb@lists.infradead.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: 
	"mohammed.al-obaidi@badraproject.com" <mohammed.al-obaidi@badraproject.com>
Message-ID: <1886262646.6291779.1777997531793@mail.yahoo.com>
Subject: [PATCH] wireless-regdb: add regulatory rules for Iraq (IQ)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6291778_1339034877.1777997531792"
References: <1886262646.6291779.1777997531793.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.25559 YMailNovation
X-Rspamd-Queue-Id: DCBA94D19BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35940-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[yahoo.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,mail.yahoo.com:mid,cmc.iq:url];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mnew_iraq@yahoo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	HAS_WP_URI(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	HAS_REPLYTO(0.00)[mnew_iraq@yahoo.com];
	NEURAL_SPAM(0.00)[0.229];
	REPLYTO_EQ_FROM(0.00)[]

------=_Part_6291778_1339034877.1777997531792
Content-Type: multipart/alternative; 
	boundary="----=_Part_6291777_1269313921.1777997531733"

------=_Part_6291777_1269313921.1777997531733
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

## 1. Why this patch exists
Iraq is currently absent from `wireless-regdb/db.txt`. As aconsequence, eve=
ry OpenWrt and Linux device set to `country=3DIQ`falls back to the world do=
main (`00`), which marks most of the5 GHz spectrum as `no IR` and limits 2.=
4 GHz EIRP to 20 dBm. Apublic OpenWrt forum thread on the Archer AX23 in Ir=
aq concludedwith the maintainers' standard answer:
> *"IQ is the correct code for the place; once an engineer shares> the loca=
l radio laws with regdb maintainers it will be added."*
This patch is that contribution.
## 2. The primary source
The Iraqi Communications and Media Commission (CMC), the nationalregulator,=
 has issued a numerical regulation specifically governingunlicensed Wi-Fi, =
SRD, and UWB devices:
- **Title:** Regulation on short-range radio communication devices=C2=A0 (S=
RD) and devices using ultra-broadband (UWB) technology- **Issuer:** Republi=
c of Iraq, CMC, Telecommunications Regulatory=C2=A0 Department, Internation=
al Relations Section- **Decree:** Council of Commissioners decision No. 122=
/q-2025- **In force from:** 2025-09-22- **Edition:** First edition, 2025; 2=
6 pages- **Direct PDF:**=C2=A0 <https://cmc.iq/wp-content/uploads/2025/09/R=
egulation-on-short-range-radio-communication-devices-SRD-and-devices-using-=
ultra-broadband-UWB-technology.pdf>
Article 4-1-13 of that regulation, titled "Wireless Access Systems(WAS)", c=
ontains a full numerical table for every Wi-Fi band. Thispatch reproduces t=
hat table directly. Nothing in the proposed`country IQ:` block is inferred =
or extrapolated.
## 3. The Article 4-1-13 table, verbatim
| Band | Use | Max EIRP | Required mitigations | Cited standard ||---|---|-=
--|---|---|| 2400 =E2=80=93 2483.5 MHz | Indoor and outdoor | 100 mW | LBT =
and DAA | EN 300 328, ERC/REC 70-03 || 5150 =E2=80=93 5250 MHz | Indoor | 2=
00 mW | =E2=80=94 | EN 301 893, ITU Res. 229 (Rev. WRC-19) || 5250 =E2=80=
=93 5350 MHz | Indoor | 200 mW | =E2=80=94 (DFS implied via EN 301 893) | E=
N 301 893 || 5470 =E2=80=93 5725 MHz | Indoor | 1000 mW | DFS and TPC (stat=
ed explicitly) | EN 301 893 || 5725 =E2=80=93 5875 MHz | Indoor and outdoor=
 | 2000 mW (10 MHz ch) / 4000 mW (20 MHz ch) | =E2=80=94 | EN 302 502 || 59=
45 =E2=80=93 6425 MHz | Indoor | 200 mW | =E2=80=94 | EN 303 687, ECC Repor=
t 75 || 57000 =E2=80=93 66000 MHz | Indoor | 10000 mW | LBT and DAA | EN 30=
2 567 |
The proposed `country IQ:` block encodes this table line for line.
## 4. The Iraqi regulation also defines its own glossary terms
For the avoidance of doubt, the regulation's Annex A explicitlydefines `Wi-=
Fi` as *"802.11 Local Area Networking in 2.4 and 5 GHzISM bands"*. So when =
the maintainers ask whether this regulationin fact covers Wi-Fi, the answer=
 from the regulator is yes,in writing, in the regulation itself.
The same annex defines DFS, TPC, LBT, DAA, EIRP and AFA in theexact wireles=
s-regdb sense.
## 5. Encoding choices and where they came from
A few wireless-regdb encoding details require explanation, becausethey are =
interpretations of the regulation's wording rather thandirect copies of num=
erical limits:
1. **NO-OUTDOOR on 5150=E2=80=935725 MHz.** The regulation labels these=C2=
=A0 =C2=A0rows simply as "Indoor". The wireless-regdb idiom for that is=C2=
=A0 =C2=A0the `NO-OUTDOOR` flag.
2. **No NO-OUTDOOR on 5725=E2=80=935875 MHz.** The regulation explicitly=C2=
=A0 =C2=A0labels this row "Indoor and outdoor".
3. **DFS on 5250=E2=80=935350 MHz.** The regulation's own column for this=
=C2=A0 =C2=A0row is empty for mitigations, but the cited standard=C2=A0 =C2=
=A0(EN 301 893) requires DFS in this sub-band, and the corresponding=C2=A0 =
=C2=A0row for 5470=E2=80=935725 in the same table does state DFS+TPC. Readi=
ng=C2=A0 =C2=A0the regulation as a whole, DFS for 5250=E2=80=935350 is requ=
ired by the=C2=A0 =C2=A0incorporated standard.
4. **Single EIRP figure for 5725=E2=80=935875 MHz.** The regulation gives=
=C2=A0 =C2=A0two figures (2000 mW for 10 MHz channels, 4000 mW for 20 MHz=
=C2=A0 =C2=A0channels). The wireless-regdb format expresses one ceiling per=
=C2=A0 =C2=A0band; the 4000 mW figure is used because it is the higher valu=
e=C2=A0 =C2=A0that the regulation explicitly permits.
5. **6 GHz channel width set to 80 MHz.** The regulation does not=C2=A0 =C2=
=A0explicitly distinguish standard-power from low-power indoor=C2=A0 =C2=A0=
(LPI) operation, nor does it mention AFC. The conservative=C2=A0 =C2=A0choi=
ce is to encode the 6 GHz block at 80 MHz (the widest=C2=A0 =C2=A0non-AFC o=
ption in current practice) and leave a follow-up patch=C2=A0 =C2=A0for a wi=
der channelisation once CMC clarifies AFC requirements.
6. **AUTO-BW on the 5 GHz RLAN rows.** Standard practice for=C2=A0 =C2=A0EN=
 301 893=E2=80=93compliant entries; no AUTO-BW is set on the 6 GHz=C2=A0 =
=C2=A0row pending the AFC question above.
If the maintainers prefer a different encoding for any of thesesix points, =
please push back; the underlying regulatory text isclear and any of these c=
an be re-encoded without changing what isactually permitted under Iraqi law=
.
## 6. The 5.8 GHz figure looks unusually high =E2=80=94 it is intentional
`(5725 - 5875 @ 80), (4000 mW)` with no NO-OUTDOOR is not a typo.This is wh=
at Iraq's own regulation states for this sub-band, citingEN 302 502. It is =
the BFWA value, not the Non-Specific SRD value.This choice puts Iraq at the=
 high end of the regional spectrumpolicy for the 5.8 GHz band. It is includ=
ed verbatim because thepurpose of wireless-regdb is to reflect what each co=
untry'sregulator actually permits.
## 7. What is not in the patch
- **5850=E2=80=935925 MHz ITS / V2X bands.** Article 4-1-8 of the same=C2=
=A0 regulation covers ITS at 5855=E2=80=935925 MHz with 2 W EIRP, but this=
=C2=A0 is a non-Wi-Fi RLAN application and is outside the scope of=C2=A0 wh=
at wireless-regdb usually encodes for `country` blocks.
- **All non-Wi-Fi SRD bands.** The regulation also covers RFID,=C2=A0 induc=
tive applications, alarms, model control, automotive radar,=C2=A0 level pro=
bing radar, hearing aids, active medical implants, and=C2=A0 the full UWB r=
egime (Articles 4-2-1 through 4-2-6). None of these=C2=A0 is a wireless-reg=
db concern.
- **6 GHz beyond 6425 MHz.** The Iraqi regulation only addresses=C2=A0 5945=
=E2=80=936425 MHz at 6 GHz; the 6425=E2=80=937125 MHz upper portion is not=
=C2=A0 covered, and the patch therefore does not include it.
## 8. Submission checklist
- [ ] Verify the patch applies cleanly against the current=C2=A0 =C2=A0 =C2=
=A0 `wireless-regdb` master; the IQ block must be inserted in=C2=A0 =C2=A0 =
=C2=A0 alphabetical order, between `IN` and `IR`.- [ ] Build `regulatory.db=
` locally and confirm with=C2=A0 =C2=A0 =C2=A0 `regdbdump regulatory.db | g=
rep -A8 'country IQ'` that the=C2=A0 =C2=A0 =C2=A0 output matches the propo=
sed table exactly.- [ ] Post the cover letter and patch on the OpenWrt foru=
m thread=C2=A0 =C2=A0 =C2=A0 (231380) for community review by Iraqi enginee=
rs before=C2=A0 =C2=A0 =C2=A0 sending upstream.- [ ] Send to `linux-wireles=
s@vger.kernel.org` with cc to=C2=A0 =C2=A0 =C2=A0 `wireless-regdb@lists.inf=
radead.org`.
## 9. A note on responsibility
The numerical content of this patch is taken verbatim from a publicIraqi go=
vernment regulation. The encoding choices listed in =C2=A75 arethe patch au=
thor's, and they are reversible.
Author: Mohammed Abdullah Ali Al-Obaidi (mnew_iraq@yahoo.com),OpenWrt forum=
 handle `mnewiraq`. Any objection to the encodingchoices should be raised t=
o that author or in the upstream reviewthread, not to the CMC.


------=_Part_6291777_1269313921.1777997531733
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"ydp4b190e52yahoo-style-wrap" style=
=3D"font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:18px=
;"><div><div dir=3D"ltr" data-setdir=3D"false"><div><div style=3D"color: rg=
b(59, 59, 59); background-color: rgb(255, 255, 255); font-family: Consolas,=
 Courier New, monospace; font-size: 14px; line-height: 19px;"><div><span st=
yle=3D"color: #800000;font-weight: bold;">## 1. Why this patch exists</span=
></div><br><div>Iraq is currently absent from <span style=3D"color: #800000=
;">`wireless-regdb/db.txt`</span>. As a</div><div>consequence, every OpenWr=
t and Linux device set to <span style=3D"color: #800000;">`country=3DIQ`</s=
pan></div><div>falls back to the world domain (<span style=3D"color: #80000=
0;">`00`</span>), which marks most of the</div><div>5 GHz spectrum as <span=
 style=3D"color: #800000;">`no IR`</span> and limits 2.4 GHz EIRP to 20 dBm=
. A</div><div>public OpenWrt forum thread on the Archer AX23 in Iraq conclu=
ded</div><div>with the maintainers' standard answer:</div><br><div><span st=
yle=3D"color: #0451a5;">&gt;</span> *"IQ is the correct code for the place;=
 once an engineer shares</div><div><span style=3D"color: #0451a5;">&gt;</sp=
an> the local radio laws with regdb maintainers it will be added."*</div><b=
r><div>This patch is that contribution.</div><br><div><span style=3D"color:=
 #800000;font-weight: bold;">## 2. The primary source</span></div><br><div>=
The Iraqi Communications and Media Commission (CMC), the national</div><div=
>regulator, has issued a numerical regulation specifically governing</div><=
div>unlicensed Wi-Fi, SRD, and UWB devices:</div><br><div><span style=3D"co=
lor: #0451a5;">-</span> <span style=3D"color: #000080;font-weight: bold;">*=
*Title:**</span> Regulation on short-range radio communication devices</div=
><div>&nbsp; (SRD) and devices using ultra-broadband (UWB) technology</div>=
<div><span style=3D"color: #0451a5;">-</span> <span style=3D"color: #000080=
;font-weight: bold;">**Issuer:**</span> Republic of Iraq, CMC, Telecommunic=
ations Regulatory</div><div>&nbsp; Department, International Relations Sect=
ion</div><div><span style=3D"color: #0451a5;">-</span> <span style=3D"color=
: #000080;font-weight: bold;">**Decree:**</span> Council of Commissioners d=
ecision No. 122/q-2025</div><div><span style=3D"color: #0451a5;">-</span> <=
span style=3D"color: #000080;font-weight: bold;">**In force from:**</span> =
2025-09-22</div><div><span style=3D"color: #0451a5;">-</span> <span style=
=3D"color: #000080;font-weight: bold;">**Edition:**</span> First edition, 2=
025; 26 pages</div><div><span style=3D"color: #0451a5;">-</span> <span styl=
e=3D"color: #000080;font-weight: bold;">**Direct PDF:**</span></div><div>&n=
bsp; &lt;<span style=3D"text-decoration: underline;">https://cmc.iq/wp-cont=
ent/uploads/2025/09/Regulation-on-short-range-radio-communication-devices-S=
RD-and-devices-using-ultra-broadband-UWB-technology.pdf</span>&gt;</div><br=
><div>Article 4-1-13 of that regulation, titled "Wireless Access Systems</d=
iv><div>(WAS)", contains a full numerical table for every Wi-Fi band. This<=
/div><div>patch reproduces that table directly. Nothing in the proposed</di=
v><div><span style=3D"color: #800000;">`country IQ:`</span> block is inferr=
ed or extrapolated.</div><br><div><span style=3D"color: #800000;font-weight=
: bold;">## 3. The Article 4-1-13 table, verbatim</span></div><br><div>| Ba=
nd | Use | Max EIRP | Required mitigations | Cited standard |</div><div>|--=
-|---|---|---|---|</div><div>| 2400 =E2=80=93 2483.5 MHz | Indoor and outdo=
or | 100 mW | LBT and DAA | EN 300 328, ERC/REC 70-03 |</div><div>| 5150 =
=E2=80=93 5250 MHz | Indoor | 200 mW | =E2=80=94 | EN 301 893, ITU Res. 229=
 (Rev. WRC-19) |</div><div>| 5250 =E2=80=93 5350 MHz | Indoor | 200 mW | =
=E2=80=94 (DFS implied via EN 301 893) | EN 301 893 |</div><div>| 5470 =E2=
=80=93 5725 MHz | Indoor | 1000 mW | DFS and TPC (stated explicitly) | EN 3=
01 893 |</div><div>| 5725 =E2=80=93 5875 MHz | Indoor and outdoor | 2000 mW=
 (10 MHz ch) / 4000 mW (20 MHz ch) | =E2=80=94 | EN 302 502 |</div><div>| 5=
945 =E2=80=93 6425 MHz | Indoor | 200 mW | =E2=80=94 | EN 303 687, ECC Repo=
rt 75 |</div><div>| 57000 =E2=80=93 66000 MHz | Indoor | 10000 mW | LBT and=
 DAA | EN 302 567 |</div><br><div>The proposed <span style=3D"color: #80000=
0;">`country IQ:`</span> block encodes this table line for line.</div><br><=
div><span style=3D"color: #800000;font-weight: bold;">## 4. The Iraqi regul=
ation also defines its own glossary terms</span></div><br><div>For the avoi=
dance of doubt, the regulation's Annex A explicitly</div><div>defines <span=
 style=3D"color: #800000;">`Wi-Fi`</span> as *"802.11 Local Area Networking=
 in 2.4 and 5 GHz</div><div>ISM bands"*. So when the maintainers ask whethe=
r this regulation</div><div>in fact covers Wi-Fi, the answer from the regul=
ator is yes,</div><div>in writing, in the regulation itself.</div><br><div>=
The same annex defines DFS, TPC, LBT, DAA, EIRP and AFA in the</div><div>ex=
act wireless-regdb sense.</div><br><div><span style=3D"color: #800000;font-=
weight: bold;">## 5. Encoding choices and where they came from</span></div>=
<br><div>A few wireless-regdb encoding details require explanation, because=
</div><div>they are interpretations of the regulation's wording rather than=
</div><div>direct copies of numerical limits:</div><br><div><span style=3D"=
color: #0451a5;">1.</span> <span style=3D"color: #000080;font-weight: bold;=
">**NO-OUTDOOR on 5150=E2=80=935725 MHz.**</span> The regulation labels the=
se</div><div>&nbsp; &nbsp;rows simply as "Indoor". The wireless-regdb idiom=
 for that is</div><div>&nbsp; &nbsp;the <span style=3D"color: #800000;">`NO=
-OUTDOOR`</span> flag.</div><br><div><span style=3D"color: #0451a5;">2.</sp=
an> <span style=3D"color: #000080;font-weight: bold;">**No NO-OUTDOOR on 57=
25=E2=80=935875 MHz.**</span> The regulation explicitly</div><div>&nbsp; &n=
bsp;labels this row "Indoor and outdoor".</div><br><div><span style=3D"colo=
r: #0451a5;">3.</span> <span style=3D"color: #000080;font-weight: bold;">**=
DFS on 5250=E2=80=935350 MHz.**</span> The regulation's own column for this=
</div><div>&nbsp; &nbsp;row is empty for mitigations, but the cited standar=
d</div><div>&nbsp; &nbsp;(EN 301 893) requires DFS in this sub-band, and th=
e corresponding</div><div>&nbsp; &nbsp;row for 5470=E2=80=935725 in the sam=
e table does state DFS+TPC. Reading</div><div>&nbsp; &nbsp;the regulation a=
s a whole, DFS for 5250=E2=80=935350 is required by the</div><div>&nbsp; &n=
bsp;incorporated standard.</div><br><div><span style=3D"color: #0451a5;">4.=
</span> <span style=3D"color: #000080;font-weight: bold;">**Single EIRP fig=
ure for 5725=E2=80=935875 MHz.**</span> The regulation gives</div><div>&nbs=
p; &nbsp;two figures (2000 mW for 10 MHz channels, 4000 mW for 20 MHz</div>=
<div>&nbsp; &nbsp;channels). The wireless-regdb format expresses one ceilin=
g per</div><div>&nbsp; &nbsp;band; the 4000 mW figure is used because it is=
 the higher value</div><div>&nbsp; &nbsp;that the regulation explicitly per=
mits.</div><br><div><span style=3D"color: #0451a5;">5.</span> <span style=
=3D"color: #000080;font-weight: bold;">**6 GHz channel width set to 80 MHz.=
**</span> The regulation does not</div><div>&nbsp; &nbsp;explicitly disting=
uish standard-power from low-power indoor</div><div>&nbsp; &nbsp;(LPI) oper=
ation, nor does it mention AFC. The conservative</div><div>&nbsp; &nbsp;cho=
ice is to encode the 6 GHz block at 80 MHz (the widest</div><div>&nbsp; &nb=
sp;non-AFC option in current practice) and leave a follow-up patch</div><di=
v>&nbsp; &nbsp;for a wider channelisation once CMC clarifies AFC requiremen=
ts.</div><br><div><span style=3D"color: #0451a5;">6.</span> <span style=3D"=
color: #000080;font-weight: bold;">**AUTO-BW on the 5 GHz RLAN rows.**</spa=
n> Standard practice for</div><div>&nbsp; &nbsp;EN 301 893=E2=80=93complian=
t entries; no AUTO-BW is set on the 6 GHz</div><div>&nbsp; &nbsp;row pendin=
g the AFC question above.</div><br><div>If the maintainers prefer a differe=
nt encoding for any of these</div><div>six points, please push back; the un=
derlying regulatory text is</div><div>clear and any of these can be re-enco=
ded without changing what is</div><div>actually permitted under Iraqi law.<=
/div><br><div><span style=3D"color: #800000;font-weight: bold;">## 6. The 5=
.8 GHz figure looks unusually high =E2=80=94 it is intentional</span></div>=
<br><div><span style=3D"color: #800000;">`(5725 - 5875 @ 80), (4000 mW)`</s=
pan> with no NO-OUTDOOR is not a typo.</div><div>This is what Iraq's own re=
gulation states for this sub-band, citing</div><div>EN 302 502. It is the B=
FWA value, not the Non-Specific SRD value.</div><div>This choice puts Iraq =
at the high end of the regional spectrum</div><div>policy for the 5.8 GHz b=
and. It is included verbatim because the</div><div>purpose of wireless-regd=
b is to reflect what each country's</div><div>regulator actually permits.</=
div><br><div><span style=3D"color: #800000;font-weight: bold;">## 7. What i=
s not in the patch</span></div><br><div><span style=3D"color: #0451a5;">-</=
span> <span style=3D"color: #000080;font-weight: bold;">**5850=E2=80=935925=
 MHz ITS / V2X bands.**</span> Article 4-1-8 of the same</div><div>&nbsp; r=
egulation covers ITS at 5855=E2=80=935925 MHz with 2 W EIRP, but this</div>=
<div>&nbsp; is a non-Wi-Fi RLAN application and is outside the scope of</di=
v><div>&nbsp; what wireless-regdb usually encodes for <span style=3D"color:=
 #800000;">`country`</span> blocks.</div><br><div><span style=3D"color: #04=
51a5;">-</span> <span style=3D"color: #000080;font-weight: bold;">**All non=
-Wi-Fi SRD bands.**</span> The regulation also covers RFID,</div><div>&nbsp=
; inductive applications, alarms, model control, automotive radar,</div><di=
v>&nbsp; level probing radar, hearing aids, active medical implants, and</d=
iv><div>&nbsp; the full UWB regime (Articles 4-2-1 through 4-2-6). None of =
these</div><div>&nbsp; is a wireless-regdb concern.</div><br><div><span sty=
le=3D"color: #0451a5;">-</span> <span style=3D"color: #000080;font-weight: =
bold;">**6 GHz beyond 6425 MHz.**</span> The Iraqi regulation only addresse=
s</div><div>&nbsp; 5945=E2=80=936425 MHz at 6 GHz; the 6425=E2=80=937125 MH=
z upper portion is not</div><div>&nbsp; covered, and the patch therefore do=
es not include it.</div><br><div><span style=3D"color: #800000;font-weight:=
 bold;">## 8. Submission checklist</span></div><br><div><span style=3D"colo=
r: #0451a5;">-</span> [ ] Verify the patch applies cleanly against the curr=
ent</div><div>&nbsp; &nbsp; &nbsp; <span style=3D"color: #800000;">`wireles=
s-regdb`</span> master; the IQ block must be inserted in</div><div>&nbsp; &=
nbsp; &nbsp; alphabetical order, between <span style=3D"color: #800000;">`I=
N`</span> and <span style=3D"color: #800000;">`IR`</span>.</div><div><span =
style=3D"color: #0451a5;">-</span> [ ] Build <span style=3D"color: #800000;=
">`regulatory.db`</span> locally and confirm with</div><div>&nbsp; &nbsp; &=
nbsp; <span style=3D"color: #800000;">`regdbdump regulatory.db | grep -A8 '=
country IQ'`</span> that the</div><div>&nbsp; &nbsp; &nbsp; output matches =
the proposed table exactly.</div><div><span style=3D"color: #0451a5;">-</sp=
an> [ ] Post the cover letter and patch on the OpenWrt forum thread</div><d=
iv>&nbsp; &nbsp; &nbsp; (231380) for community review by Iraqi engineers be=
fore</div><div>&nbsp; &nbsp; &nbsp; sending upstream.</div><div><span style=
=3D"color: #0451a5;">-</span> [ ] Send to <span style=3D"color: #800000;">`=
linux-wireless@vger.kernel.org`</span> with cc to</div><div>&nbsp; &nbsp; &=
nbsp; <span style=3D"color: #800000;">`wireless-regdb@lists.infradead.org`<=
/span>.</div><br><div><span style=3D"color: #800000;font-weight: bold;">## =
9. A note on responsibility</span></div><br><div>The numerical content of t=
his patch is taken verbatim from a public</div><div>Iraqi government regula=
tion. The encoding choices listed in =C2=A75 are</div><div>the patch author=
's, and they are reversible.</div><br><div>Author: Mohammed Abdullah Ali Al=
-Obaidi (mnew_iraq@yahoo.com),</div><div>OpenWrt forum handle <span style=
=3D"color: #800000;">`mnewiraq`</span>. Any objection to the encoding</div>=
<div>choices should be raised to that author or in the upstream review</div=
><div>thread, not to the CMC.</div><br></div></div><br></div></div></div></=
body></html>
------=_Part_6291777_1269313921.1777997531733--

------=_Part_6291778_1339034877.1777997531792
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-wireless-regdb-add-Iraq-IQ-entry-2.patch"
Content-ID: <a4f72896-1dd7-4807-0dbb-463702ffe852@yahoo.com>

RnJvbTogTW9oYW1tZWQgQWJkdWxsYWggQWxpIEFsLU9iYWlkaSA8bW5ld19pcmFxQHlhaG9vLmNv
bT4KU3ViamVjdDogW1BBVENIXSB3aXJlbGVzcy1yZWdkYjogYWRkIHJlZ3VsYXRvcnkgcnVsZXMg
Zm9yIElyYXEgKElRKQoKQWRkIGEgcmVndWxhdG9yeSBlbnRyeSBmb3IgSXJhcSAoSVNPIDMxNjYt
MSBhbHBoYS0yOiBJUSkuCgpJcmFxIGlzIGN1cnJlbnRseSBhYnNlbnQgZnJvbSB0aGUgcmVndWxh
dG9yeSBkYXRhYmFzZS4gRGV2aWNlcyBzZXQKdG8gY291bnRyeT1JUSBmYWxsIGJhY2sgdG8gdGhl
IHdvcmxkIGRvbWFpbiAoMDApLCB3aGljaCBsZWF2ZXMgbW9zdApvZiB0aGUgNSBHSHogc3BlY3Ry
dW0gbWFya2VkICJubyBJUiIgYW5kIHNldmVyZWx5IHJlc3RyaWN0cyBldmVuCjIuNCBHSHogb3Bl
cmF0aW9uLiBUaGUgSXJhcWkgQ29tbXVuaWNhdGlvbnMgYW5kIE1lZGlhIENvbW1pc3Npb24KKENN
QykgaGFzIG5vdyBwdWJsaXNoZWQgYW4gZXhwbGljaXQsIG51bWVyaWNhbCBuYXRpb25hbCByZWd1
bGF0aW9uCnRoYXQgZmlsbHMgdGhpcyBnYXAuCgpTb3VyY2UgZG9jdW1lbnQKLS0tLS0tLS0tLS0t
LS0tCgogIFRpdGxlIDogUmVndWxhdGlvbiBvbiBzaG9ydC1yYW5nZSByYWRpbyBjb21tdW5pY2F0
aW9uIGRldmljZXMKICAgICAgICAgIChTUkQpIGFuZCBkZXZpY2VzIHVzaW5nIHVsdHJhLWJyb2Fk
YmFuZCAoVVdCKSB0ZWNobm9sb2d5CiAgSXNzdWVyOiBSZXB1YmxpYyBvZiBJcmFxLCBDb21tdW5p
Y2F0aW9ucyBhbmQgTWVkaWEgQ29tbWlzc2lvbgogICAgICAgICAgKENNQyksIFRlbGVjb21tdW5p
Y2F0aW9ucyBSZWd1bGF0b3J5IERlcGFydG1lbnQsCiAgICAgICAgICBJbnRlcm5hdGlvbmFsIFJl
bGF0aW9ucyBTZWN0aW9uCiAgRGVjcmVlOiBDb3VuY2lsIG9mIENvbW1pc3Npb25lcnMgZGVjaXNp
b24gTm8uIDEyMi9xLTIwMjUKICBJbiBmb3JjZSBmcm9tOiAyMDI1LTA5LTIyCiAgRWRpdGlvbjog
Rmlyc3QgZWRpdGlvbiwgMjAyNTsgMjYgcGFnZXMKICBVUkwgICA6IGh0dHBzOi8vY21jLmlxL3dw
LWNvbnRlbnQvdXBsb2Fkcy8yMDI1LzA5L1JlZ3VsYXRpb24tb24tc2hvcnQtcmFuZ2UtcmFkaW8t
Y29tbXVuaWNhdGlvbi1kZXZpY2VzLVNSRC1hbmQtZGV2aWNlcy11c2luZy11bHRyYS1icm9hZGJh
bmQtVVdCLXRlY2hub2xvZ3kucGRmCgpUaGUgdmFsdWVzIGJlbG93IGFyZSB0YWtlbiBkaXJlY3Rs
eSBmcm9tIEFydGljbGUgNC0xLTEzICgiV2lyZWxlc3MKQWNjZXNzIFN5c3RlbXMgLyBXQVMiKSBv
ZiB0aGF0IHJlZ3VsYXRpb24sIHdoaWNoIGlzIHRoZSB0YWJsZQpnb3Zlcm5pbmcgV2ktRmkgKEFu
bmV4IEEgb2YgdGhlIHJlZ3VsYXRpb24gZGVmaW5lcyBXaS1GaSBhcwoiODAyLjExIExvY2FsIEFy
ZWEgTmV0d29ya2luZyBpbiAyLjQgYW5kIDUgR0h6IElTTSBiYW5kcyIpLiBUaGlzCmlzIG5vdCBh
IGRlcml2ZWQgcmVhZGluZzogZXZlcnkgYmFuZCwgZXZlcnkgRUlSUCB2YWx1ZSwgZXZlcnkKaW5k
b29yIHJlc3RyaWN0aW9uLCBhbmQgZXZlcnkgcmVxdWlyZWQgbWl0aWdhdGlvbiAoTEJUL0RBQSwg
REZTLApUUEMpIGlzIG5hbWVkIGluIHRoZSByZWd1bGF0aW9uIGl0c2VsZi4KCkJhbmRzIGFuZCBs
aW1pdHMsIGFzIHN0YXRlZCBpbiBBcnRpY2xlIDQtMS0xMzoKCiAgMjQwMC0yNDgzLjUgTUh6ICA6
IDEwMCAgbVcgRUlSUCwgaW5kb29yIGFuZCBvdXRkb29yLCBMQlQvREFBCiAgICAgICAgICAgICAg
ICAgICAgIChFTiAzMDAgMzI4LCBFUkMvUkVDIDcwLTAzKQogIDUxNTAtNTI1MCBNSHogICAgOiAy
MDAgIG1XIEVJUlAsIGluZG9vcgogICAgICAgICAgICAgICAgICAgICAoRU4gMzAxIDg5MywgSVRV
LVIgUmVzLiAyMjkgUmV2LiBXUkMtMTkpCiAgNTI1MC01MzUwIE1IeiAgICA6IDIwMCAgbVcgRUlS
UCwgaW5kb29yCiAgICAgICAgICAgICAgICAgICAgIChFTiAzMDEgODkzKSAgLS0gREZTIGltcGxp
ZWQgdmlhIEVOIDMwMSA4OTMKICA1NDcwLTU3MjUgTUh6ICAgIDogMTAwMCBtVyBFSVJQLCBpbmRv
b3IsIERGUyArIFRQQwogICAgICAgICAgICAgICAgICAgICAoRU4gMzAxIDg5MykKICA1NzI1LTU4
NzUgTUh6ICAgIDogMjAwMCBtVyBFSVJQICgxMCBNSHogY2gpIC8gNDAwMCBtVyAoMjAgTUh6IGNo
KSwKICAgICAgICAgICAgICAgICAgICAgaW5kb29yIGFuZCBvdXRkb29yCiAgICAgICAgICAgICAg
ICAgICAgIChFTiAzMDIgNTAyKQogIDU5NDUtNjQyNSBNSHogICAgOiAyMDAgIG1XIEVJUlAsIGlu
ZG9vcgogICAgICAgICAgICAgICAgICAgICAoRU4gMzAzIDY4NywgRUNDIFJlcG9ydCA3NSkKICA1
Ny02NiBHSHogICAgICAgIDogMTAgICBXICBFSVJQLCBpbmRvb3IsIExCVC9EQUEKICAgICAgICAg
ICAgICAgICAgICAgKEVOIDMwMiA1NjcpCgpOb3RlcyBvbiB0aGUgZW5jb2RpbmcgY2hvc2VuIGJl
bG93Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCiogVGhlIElyYXFpIHJlZ3Vs
YXRpb24gbGlzdHMgYmFuZHMgMiB0aHJvdWdoIDQgKDUxNTAtNTcyNSBNSHopIGFzCiAgIkluZG9v
ciI7IHRoaXMgaXMgZW5jb2RlZCBhcyBOTy1PVVRET09SLgoqIFRoZSByZWd1bGF0aW9uIGxpc3Rz
IDU3MjUtNTg3NSBNSHogYXMgIkluZG9vciBhbmQgb3V0ZG9vciI7IG5vCiAgTk8tT1VURE9PUiBm
bGFnIGlzIGFwcGxpZWQgdG8gdGhhdCByb3cuCiogREZTIGZvciA1MjUwLTUzNTAgaXMgcmVxdWly
ZWQgYnkgRU4gMzAxIDg5Mywgd2hpY2ggdGhlIHJlZ3VsYXRpb24KICByZWZlcmVuY2VzOyB0aGUg
REZTIGZsYWcgaXMgaW5jbHVkZWQgYWNjb3JkaW5nbHkuCiogREZTIGFuZCBUUEMgZm9yIDU0NzAt
NTcyNSBhcmUgc3RhdGVkIGV4cGxpY2l0bHkgaW4gdGhlIHJlZ3VsYXRpb24KICAoIkRGUyAmIFRQ
QyBzaGFsbCBiZSBpbXBsZW1lbnRlZCBhcyBhZGVxdWF0ZSBzaGFyaW5nIG1lY2hhbmlzbSIpLgoq
IDU3MjUtNTg3NSBNSHogdXNlcyB0aGUgaGlnaGVyIG9mIHRoZSB0d28gc3RhdGVkIEVJUlAgZmln
dXJlcwogICg0MDAwIG1XIGZvciAyMCBNSHogY2hhbm5lbHMpIHNpbmNlIHdpcmVsZXNzLXJlZ2Ri
IGV4cHJlc3NlcyBhCiAgcGVyLWJhbmQgY2VpbGluZywgbm90IGEgcGVyLWNoYW5uZWwtd2lkdGgg
Y2VpbGluZy4KKiBBVVRPLUJXIGlzIHNldCBvbiB0aGUgNSBHSHogUkxBTiBiYW5kcyBjb25zaXN0
ZW50IHdpdGggRU4gMzAxIDg5My4KKiBUaGUgNiBHSHogYmxvY2sgaXMgZW5jb2RlZCBhdCB0aGUg
ODAgTUh6IGNoYW5uZWwgd2lkdGggd2hpY2ggaXMKICB0aGUgd2lkZXN0IHN0YW5kYXJkLXBvd2Vy
IG9wdGlvbjsgaXQgY2FuIGJlIHdpZGVuZWQgaW4gYSBmb2xsb3ctdXAKICBwYXRjaCBpZiBhbmQg
d2hlbiBDTUMgY2xhcmlmaWVzIEFGQyByZXF1aXJlbWVudHMuCiogNjAgR0h6OiB0aGUgcmVndWxh
dGlvbiBzcGVjaWZpZXMgNTctNjYgR0h6OyB0aGlzIG1hdGNoZXMgdGhlCiAgZXhpc3Rpbmcgd2ly
ZWxlc3MtcmVnZGIgY29udmVudGlvbiB1c2VkIGJ5IG90aGVyIEVUU0kgY291bnRyaWVzLgoKQmFj
a2dyb3VuZCBvbiB0aGUgdW5pcXVlIDUuOCBHSHogZmlndXJlCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQoKVGhlIDQwMDAgbVcgRUlSUCBmb3IgNTcyNS01ODc1IE1IeiB3
aXRoIGJvdGggaW5kb29yIGFuZCBvdXRkb29yCm9wZXJhdGlvbiBpcyBub3QgdGhlIGNvbnNlcnZh
dGl2ZSBFdXJvcGVhbiBmaWd1cmU7IGl0IHJlZmxlY3RzIGFuCmV4cGxpY2l0IElyYXFpIG5hdGlv
bmFsIGNob2ljZSB0aGF0IGZvbGxvd3MgRU4gMzAyIDUwMiAoQkZXQSkuClRoaXMgaXMgaW5jbHVk
ZWQgdmVyYmF0aW0gZnJvbSB0aGUgcmVndWxhdGlvbi4KCkRpc2N1c3Npb24gdGhyZWFkIG9uIHRo
ZSBPcGVuV3J0IGZvcnVtIHdoZXJlIHRoaXMgd29yayB3YXMKc29saWNpdGVkOgoKICBodHRwczov
L2ZvcnVtLm9wZW53cnQub3JnL3QvY29uZmlndXJpbmctb3BlbndydC1vbi1hcmNoZXItYXgyMy1p
bi1pcmFxLzIzMTM4MAoKU2lnbmVkLW9mZi1ieTogTW9oYW1tZWQgQWJkdWxsYWggQWxpIEFsLU9i
YWlkaSA8bW5ld19pcmFxQHlhaG9vLmNvbT4KLS0tCiBkYi50eHQgfCAxNCArKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kYi50eHQg
Yi9kYi50eHQKLS0tIGEvZGIudHh0CisrKyBiL2RiLnR4dApAQCAtaW5zZXJ0LWFmdGVyLUlOLWJs
b2NrQEAKKyMgSXJhcQorIyBTb3VyY2U6IFJlZ3VsYXRpb24gb24gc2hvcnQtcmFuZ2UgcmFkaW8g
Y29tbXVuaWNhdGlvbiBkZXZpY2VzIChTUkQpCisjIGFuZCBkZXZpY2VzIHVzaW5nIHVsdHJhLWJy
b2FkYmFuZCAoVVdCKSB0ZWNobm9sb2d5LCBGaXJzdCBFZGl0aW9uCisjIDIwMjUsIGlzc3VlZCBi
eSB0aGUgSXJhcWkgQ29tbXVuaWNhdGlvbnMgYW5kIE1lZGlhIENvbW1pc3Npb24gKENNQykKKyMg
dW5kZXIgQ291bmNpbCBvZiBDb21taXNzaW9uZXJzIGRlY2lzaW9uIE5vLiAxMjIvcS0yMDI1LCBp
biBmb3JjZQorIyBmcm9tIDIwMjUtMDktMjIuIExpbWl0cyBiZWxvdyBhcmUgdGFrZW4gZnJvbSBB
cnRpY2xlIDQtMS0xMworIyAoV2lyZWxlc3MgQWNjZXNzIFN5c3RlbXMpIG9mIHRoYXQgcmVndWxh
dGlvbi4KKyMgaHR0cHM6Ly9jbWMuaXEvd3AtY29udGVudC91cGxvYWRzLzIwMjUvMDkvUmVndWxh
dGlvbi1vbi1zaG9ydC1yYW5nZS1yYWRpby1jb21tdW5pY2F0aW9uLWRldmljZXMtU1JELWFuZC1k
ZXZpY2VzLXVzaW5nLXVsdHJhLWJyb2FkYmFuZC1VV0ItdGVjaG5vbG9neS5wZGYKK2NvdW50cnkg
SVE6IERGUy1FVFNJCisJKDI0MDAgLSAyNDgzLjUgQCA0MCksICgxMDAgbVcpLCB3bW1ydWxlPUVU
U0kKKwkoNTE1MCAtIDUyNTAgQCA4MCksICgyMDAgbVcpLCBOTy1PVVRET09SLCBBVVRPLUJXLCB3
bW1ydWxlPUVUU0kKKwkoNTI1MCAtIDUzNTAgQCA4MCksICgyMDAgbVcpLCBOTy1PVVRET09SLCBE
RlMsIEFVVE8tQlcsIHdtbXJ1bGU9RVRTSQorCSg1NDcwIC0gNTcyNSBAIDE2MCksICgxMDAwIG1X
KSwgTk8tT1VURE9PUiwgREZTLCB3bW1ydWxlPUVUU0kKKwkoNTcyNSAtIDU4NzUgQCA4MCksICg0
MDAwIG1XKQorCSg1OTQ1IC0gNjQyNSBAIDgwKSwgKDIwMCBtVyksIE5PLU9VVERPT1IsIHdtbXJ1
bGU9RVRTSQorCSg1NzAwMCAtIDY2MDAwIEAgMjE2MCksICg0MCkKLS0gCjIuNDMuMAo=

------=_Part_6291778_1339034877.1777997531792--

