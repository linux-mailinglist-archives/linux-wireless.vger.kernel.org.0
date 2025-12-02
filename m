Return-Path: <linux-wireless+bounces-29457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81803C9C03C
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Dec 2025 16:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D173A912D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Dec 2025 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6C6321434;
	Tue,  2 Dec 2025 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="k/8U+71n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-110.mimecast.com (us-smtp-delivery-110.mimecast.com [170.10.133.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A40A322A25
	for <linux-wireless@vger.kernel.org>; Tue,  2 Dec 2025 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690457; cv=none; b=qRetMgjDJJbVJYizTUh0ebwCwMfpmowvegLoqL2bMqalAInA9woCnHJbRqOPdXzGRoAl4BPZ4hdSEoGWdHLF3coWAmFfHiPaPgSu/T1Nl7A/pXOd7oRuZ40ijdIPriDltDAmrqJeaA5629v8LfigSj6kZgRvb0icF+e3EclIcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690457; c=relaxed/simple;
	bh=HBTLFdkjyK5rIs48um8gsg8qxv1oM1+zgSxvsjrhLco=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oTW0MWqu8tsqmufSWiPFYiYfY57vG+MGWBPEVlOz0vBPf1h2XpaiqbgePTB6NgP0RGtQyepdZDYauH69xSIQSJQpg6+GhQLt076RZWvBKekrHT73fcXvmeXJT5FHyBOXegK994xmjomjn5dp/IHu20/ZjbCFoyw5eUS6BRNIZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com; spf=pass smtp.mailfrom=globallogic.com; dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b=k/8U+71n; arc=none smtp.client-ip=170.10.133.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=globallogic.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globallogic.com;
	s=mimecast20210517; t=1764690451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=naCbP/u3gY0AG1uRgx83wcE83GARQlL8893/DK8+wg4=;
	b=k/8U+71nkOpTdPaKMH4j6orWmHgTKqKhghYW90uoo68vyJITPMlHe/nxq36TDzJ7VzybvM
	3Gz49/p2P8nTZOG7thIa2GYARpGAo6g6NVIazNapLP4+Y+GuUkZ04q/dJnpp6qEt6+NCpa
	EkQAfvQjZaZVhBxPBpShsBiT3THFkzLz261WYVyChPu4fpPo5jJhPGVePojJpLrOY/k8Xq
	aTTvW0+WeDOW5+0r7QTz0VRlV6teSFHZcNQZOtYnNqRyWdYMxkEfCzWJC43WZWPmKtBDYj
	e2gXxdoGl8K990h8h8eT8rIDQYKapSQuwBY4pgwtqZWDNvrjgKSsPf9bwaK6Rg==
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-WNjdSET4NKKMHIGOCjmeCA-1; Tue, 02 Dec 2025 10:47:29 -0500
X-MC-Unique: WNjdSET4NKKMHIGOCjmeCA-1
X-Mimecast-MFC-AGG-ID: WNjdSET4NKKMHIGOCjmeCA_1764690448
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-37b983fbda5so29015291fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Dec 2025 07:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764690447; x=1765295247;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjDAfeBstnU+rX1IKD3m4jU1SYC5irt6HSmTfh79abQ=;
        b=K2QF2RQQBG9qeSmflV07Pvg/lvL5uU36gDbmzNmIrLXznL80lqNhHyeRPZcUYDOC16
         T26cAFGDeJG2WUks9UUh63CYvY4qq0wfZ5LL6BcBUTTAItjAVxnl2mGTveVhF9EM+YkI
         Hng9U8Z4lEx6ejfut4yDic8bp8oK2qe10yvt1ru8jmaypDdxiYbfrSxVhmmeiOkhoDcX
         bq/tQhVQ+D6SJYahHG/5fDC9UHSgT5DazCWw6wAkzI/UUHX1fVWousK22iA5sBfp0LfP
         wS2MigfmfhSb+crfxPRBz36sUliqGUPTOUVIea2StMfk8M6FP4nd6YImy0nilIfppqYB
         pv5g==
X-Gm-Message-State: AOJu0Ywf/MZT4zkSuaIcCR5OUNyffxhUyZ8GdXf8v0I55DLKh8A4ZI2x
	uX7nq8eAMGc0UDIcBECY96sxChV3ZT9+E5XPKQdTeiJMyQhr9Rp4o5mMfgAWEbAP5K04m7nkFV/
	uB1mha4r3w00Wh1PUIB/qR4IxOXmzvOT+ES4mJkZKSeOqHrR/SLNyue+46JwV7n8ufJvC2Y3Ee0
	OCuVKTP8KP69OYlrUCkCBCe1NQ/HL2Nr73lK+R0zsPnwdPM5K/Dgg=
X-Gm-Gg: ASbGncsL06yWKTo7wDWVBdlSfvLjejhCSBrxtC80OYB9OhKO3CPdtHyeAbrS8VIn3CN
	kgt0Nx0y8WXrsiPXXkWcdp1+fdL7fZQDJsn5QHLFM0OxeW3Zk9TEN6M+gETslIwZ6OvxMC1ob9t
	sXePXUPws8SYBnxvxPO3hTNuoUZWaZtGL5zIIPc8lvzfVnjBzoF2gm4jWVY8KeP8atvbM=
X-Received: by 2002:a2e:920b:0:b0:373:a93d:5b42 with SMTP id 38308e7fff4ca-37e615d5a97mr39701fa.27.1764690447149;
        Tue, 02 Dec 2025 07:47:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHr7Va0g4swYpgzF8UFcpl3dbZt8OKtHj+9rGFVFZsqghN1C75nBp+a/BQ7g8hCobx2S1YTM/c6CQ4mhZgB0v8=
X-Received: by 2002:a2e:920b:0:b0:373:a93d:5b42 with SMTP id
 38308e7fff4ca-37e615d5a97mr39601fa.27.1764690446544; Tue, 02 Dec 2025
 07:47:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jozef Marko <jozef.marko@globallogic.com>
Date: Tue, 2 Dec 2025 16:46:49 +0100
X-Gm-Features: AWmQ_bmwDhcL4tIc4PjctYkniEonOV1thyIFe2Gw-479f0ANtsTRp_kCNPWW1rk
Message-ID: <CA+Fox+xtL17pYJkDJ5Dob+VyRUe9h7hrR8=VHcJB1ZQHA89-5Q@mail.gmail.com>
Subject: wifi: mac80211: Kernel Panic (Null Pointer Dereference)
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hqRSqsssWqNHuR64o1gWhhSKs7KRyMbGGmPHPlzO84g_1764690448
X-Mimecast-Originator: globallogic.com
Content-Type: multipart/mixed; boundary="00000000000034a93c0644fa0334"

--00000000000034a93c0644fa0334
Content-Type: multipart/alternative; boundary="00000000000034a93a0644fa0332"

--00000000000034a93a0644fa0332
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi team,

I am trying to connect two Banana PI BPI-R3 (Mediatek MT7986) devices using
their WiFi interfaces=E2=80=94one acting as a hub, the other as an extender=
.
I am using Indigo firmware (based on OpenWRT 24.10.0).
In BPI3 hub I have created main WiFi interfaces 2.4 GHz and 5 GHz and
backhaul WiFi interfaces 2.4 GHz and 5 GHz.

When the BPI3 extender connects to the hub, the BPI3 hub creates a WDS
interface on the backhaul wifi interface for ieee1905 packets.
I observed a Kernel Panic (Null Pointer Dereference) in the BPI3 hub while
switching channels in the mac80211 version 6.12.6 module.
I also noticed this crash occurs when 802.11ax is enabled. When 802.11ax is
disabled, I did not observe the crash.
So, there are two prerequisites: a WDS interface created and the 802.11ax
standard enabled.

*1. Original Issue and Stack Trace*

The attached "*BPI3_hub_logread_crash.txt*" log shows that messages from
hostapd and a series of channel selection calculations by csmngr, the
system experiences an immediate and fatal crash (Kernel Panic), leading to
a system reboot.

Critical Log Entries:

[388993.190708] Unable to handle kernel read from unreadable memory at
virtual address 0000000000000000
...
[388993.728956] Kernel panic - not syncing: Oops: Fatal exception

This sequence clearly indicates an attempt to read from address 0x0 (a NULL
pointer dereference), which triggers the Kernel Panic.

Stack Trace Summary: The crash happens inside the mac80211 code,
specifically during the processing of station capabilities and channel
contexts related to bandwidth:

[388993.556018] pc : _ieee80211_sta_cap_rx_bw+0x14/0xcc [mac80211]
[388993.561959] lr : _ieee80211_sta_cur_vht_bw+0x20/0xa4 [mac80211]
...
[388993.647313]  _ieee80211_sta_cap_rx_bw+0x14/0xcc [mac80211]
[388993.652901]  ieee80211_iter_chan_contexts_atomic+0x260/0xf3c [mac80211]
[388993.659613]  ieee80211_link_unreserve_chanctx+0x424/0xaac [mac80211]
[388993.666072]  ieee80211_link_use_reserved_context+0xac/0xf4 [mac80211]
...
The root cause is likely a NULL pointer dereference within the
ieee80211_channel_def structure, accessed when determining the bandwidth
capabilities of a station while iterating channel contexts.
This points directly to the variable assignment flow in
ieee80211_chan_bw_change.

BTW: Very interesting is calling the function
ieee80211_link_unreserve_chanctx right before crash.

*2. Proposed Patch (Fix)*

An attached "*342-wifi-mac80211-fix-reserved-chan.patch*" is proposed for
net/mac80211/chan.c to introduce a sanity check and fallback mechanism when
dealing with reserved channel operation definitions that might contain an
invalid channel context (i.e., a NULL channel pointer).

Location of Change: net/mac80211/chan.c within the function
ieee80211_chan_bw_change.

Patch Justification:
The original code unconditionally set new_chandef to the reserved operation
(&link->reserved.oper;) if reserved was true.
The patch adds a crucial check: If reserved is true, it assigns new_chandef
=3D &link->reserved.oper; as before.
The Critical Fix: It then checks if the channel pointer inside it
(new_chandef->chan) is NULL.
If new_chandef->chan is NULL (as confirmed by the original crash's address
0000000000000000), it indicates an invalid channel context, which would
cause the subsequent crash.
If the reserved context is found to be invalid, the code triggers a WARNING
message and re-assigns new_chandef to the non-reserved, requested channel
definition (&link_conf->chanreq.oper).
This fallback prevents the NULL pointer dereference and the subsequent
Kernel Panic.

*3. Log with Applied Patch*

Result After Applying the Patch:
The attached "*BPI3_hub_chan_switch_crash_protection.txt*" log with the
patch applied confirms that the error scenario was hit, but the Kernel
Panic was successfully avoided. Instead, the custom WARNING message was
logged:

WARNING Message:

[  209.602618] NULL dereference crash protection reserved new_chandef->chan
=3D 0000000000000000
[  209.610978] WARNING: CPU: 2 PID: 551 at
ieee80211_iter_chan_contexts_atomic+0x2d0/0xf5c [mac80211]

This message, inserted by the patch, confirms:
A state was detected where new_chandef->chan was NULL (value
0000000000000000), which would have caused the original crash.
The crash protection mechanism triggered the warning and switched to the
backup channel structure, successfully preventing the NULL pointer
dereference.
System Behavior: The system did not panic and continued execution.
Subsequent log entries show further operations, confirming system stability
was maintained.

Conclusion:
The proposed patch is crucial for addressing a NULL pointer dereference
vulnerability in ieee80211_chan_bw_change related to improperly formed
reserved channel contexts. Its application prevents a system-critical
Kernel Panic during dynamic wireless operations.

Best regards,
Jozef Marko

Jozef Marko | Software Engineer

--00000000000034a93a0644fa0332
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi team,<br><br>I am trying to connect two Banana PI =
BPI-R3 (Mediatek MT7986) devices using their WiFi interfaces=E2=80=94one ac=
ting as a hub, the other as an extender.<br>I am using Indigo firmware (bas=
ed on OpenWRT 24.10.0).<br>In BPI3 hub I have created main WiFi interfaces =
2.4 GHz and 5 GHz and backhaul WiFi interfaces 2.4 GHz and 5 GHz.<br><br>Wh=
en the BPI3 extender connects to the hub, the BPI3 hub creates a WDS interf=
ace on the backhaul wifi interface for ieee1905 packets.<br>I observed a Ke=
rnel Panic (Null Pointer Dereference) in the BPI3 hub while switching chann=
els in the mac80211 version 6.12.6 module.<br>I also noticed this crash occ=
urs when 802.11ax is enabled. When 802.11ax is disabled, I did not observe =
the crash.</div><div>So, there are two prerequisites: a WDS interface creat=
ed and the 802.11ax standard enabled.<br></div><div><br><b><font size=3D"4"=
>1. Original Issue and Stack Trace</font></b><br><br></div><div>The attache=
d &quot;<b>BPI3_hub_logread_crash.txt</b>&quot; log shows that messages fro=
m hostapd and a series of channel selection calculations by csmngr, the sys=
tem experiences an immediate and fatal crash (Kernel Panic), leading to a s=
ystem reboot.<br><br>Critical Log Entries:<br><br>[388993.190708] Unable to=
 handle kernel read from unreadable memory at virtual address 0000000000000=
000<br>...<br>[388993.728956] Kernel panic - not syncing: Oops: Fatal excep=
tion<br><br>This sequence clearly indicates an attempt to read from address=
 0x0 (a NULL pointer dereference), which triggers the Kernel Panic.<br><br>=
</div><div>Stack Trace Summary: The crash happens inside the mac80211 code,=
 specifically during the processing of station capabilities and channel con=
texts related to bandwidth:<br><br>[388993.556018] pc : _ieee80211_sta_cap_=
rx_bw+0x14/0xcc [mac80211]<br>[388993.561959] lr : _ieee80211_sta_cur_vht_b=
w+0x20/0xa4 [mac80211]<br>...<br>[388993.647313] =C2=A0_ieee80211_sta_cap_r=
x_bw+0x14/0xcc [mac80211]<br>[388993.652901] =C2=A0ieee80211_iter_chan_cont=
exts_atomic+0x260/0xf3c [mac80211]<br>[388993.659613] =C2=A0ieee80211_link_=
unreserve_chanctx+0x424/0xaac [mac80211]<br>[388993.666072] =C2=A0ieee80211=
_link_use_reserved_context+0xac/0xf4 [mac80211]<br>...<br>The root cause is=
 likely a NULL pointer dereference within the ieee80211_channel_def structu=
re, accessed when determining the bandwidth capabilities of a station while=
 iterating channel contexts.</div><div>This points directly to the variable=
 assignment flow in ieee80211_chan_bw_change.<br><br></div><div>BTW: Very i=
nteresting is calling the function ieee80211_link_unreserve_chanctx right b=
efore crash.<br><br><b><font size=3D"4">2. Proposed Patch (Fix)</font></b><=
/div><div><b><br></b>An attached &quot;<b>342-wifi-mac80211-fix-reserved-ch=
an.patch</b>&quot; is proposed for net/mac80211/chan.c to introduce a sanit=
y check and fallback mechanism when dealing with reserved channel operation=
 definitions that might contain an invalid channel context (i.e., a NULL ch=
annel pointer).<br><br>Location of Change: net/mac80211/chan.c within the f=
unction ieee80211_chan_bw_change.<br><br>Patch Justification:<br>The origin=
al code unconditionally set new_chandef to the reserved operation (&amp;lin=
k-&gt;reserved.oper;) if reserved was true.<br>The patch adds a crucial che=
ck: If reserved is true, it assigns new_chandef =3D &amp;link-&gt;reserved.=
oper; as before.<br>The Critical Fix: It then checks if the channel pointer=
 inside it (new_chandef-&gt;chan) is NULL.<br>If new_chandef-&gt;chan is NU=
LL (as confirmed by the original crash&#39;s address 0000000000000000), it =
indicates an invalid channel context, which would cause the subsequent cras=
h.<br>If the reserved context is found to be invalid, the code triggers a W=
ARNING message and re-assigns new_chandef to the non-reserved, requested ch=
annel definition (&amp;link_conf-&gt;chanreq.oper).=C2=A0</div><div>This fa=
llback prevents the NULL pointer dereference and the subsequent Kernel Pani=
c.<br><br><b><font size=3D"4">3. Log with Applied Patch</font></b></div><di=
v><b><br></b>Result After Applying the Patch:<br>The attached &quot;<b>BPI3=
_hub_chan_switch_crash_protection.txt</b>&quot; log with the patch applied =
confirms that the error scenario was hit, but the Kernel Panic was successf=
ully avoided. Instead, the custom WARNING message was logged:<br><br>WARNIN=
G Message:<br><br>[ =C2=A0209.602618] NULL dereference crash protection res=
erved new_chandef-&gt;chan =3D 0000000000000000<br>[ =C2=A0209.610978] WARN=
ING: CPU: 2 PID: 551 at ieee80211_iter_chan_contexts_atomic+0x2d0/0xf5c [ma=
c80211]<br><br>This message, inserted by the patch, confirms:<br>A state wa=
s detected where new_chandef-&gt;chan was NULL (value 0000000000000000), wh=
ich would have caused the original crash.<br>The crash protection mechanism=
 triggered the warning and switched to the backup channel structure, succes=
sfully preventing the NULL pointer dereference.<br>System Behavior: The sys=
tem did not panic and continued execution. Subsequent log entries show furt=
her operations, confirming system stability was maintained.<br><br>Conclusi=
on:<br>The proposed patch is crucial for addressing a NULL pointer derefere=
nce vulnerability in ieee80211_chan_bw_change related to improperly formed =
reserved channel contexts. Its application prevents a system-critical Kerne=
l Panic during dynamic wireless operations.<br><br></div><div>Best regards,=
<br>Jozef Marko</div><div><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><span style=3D"color=
:rgb(136,136,136);font-size:12.8px;vertical-align:baseline;font-family:Aria=
l;font-weight:bold"><br></span></div><div dir=3D"ltr"><p dir=3D"ltr" style=
=3D"line-height:1.656;margin-top:0pt;margin-bottom:0pt"><span style=3D"font=
-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transparent;=
vertical-align:baseline"><span style=3D"border:none;display:inline-block;ov=
erflow:hidden;width:147px;height:33px"><img src=3D"https://lh5.googleuserco=
ntent.com/fdQzC6Fqnr6QWbTzQhhJgPWDXL1XAApJUOkZ_ryaCa77QARtD5aFlJSOp0gpDoXZU=
zcaA0ReAlypBIBmhncLg9W5jEAZD819AgXmvVYNurVVb-JEyehshlNQpQFcm60BQwzGOgI7" wi=
dth=3D"147" height=3D"33" class=3D"gmail-CToWUd" style=3D"margin-left: 0px;=
 margin-top: 0px;"></span></span></p><p dir=3D"ltr" style=3D"line-height:1.=
656;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:10pt;font-fa=
mily:Arial;color:rgb(0,0,0);background-color:transparent;font-weight:700;ve=
rtical-align:baseline">Jozef Marko | Software Engineer</span></p></div></di=
v></div></div></div></div></div><div><div dir=3D"ltr" class=3D"gmail_signat=
ure" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><=
div dir=3D"ltr"><span style=3D"color:rgb(136,136,136);font-size:12.8px;vert=
ical-align:baseline;font-family:Arial;font-weight:bold"><br></span></div><d=
iv dir=3D"ltr"><span><p dir=3D"ltr" style=3D"line-height:1.656;margin-top:0=
pt;margin-bottom:0pt"><br></p></span></div></div></div></div></div></div>

--00000000000034a93a0644fa0332--

--00000000000034a93c0644fa0334
Content-Type: text/plain; charset=WINDOWS-1252; 
	name=BPI3_hub_logread_crash.txt
Content-Disposition: attachment; filename="BPI3_hub_logread_crash.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mioqs0ec0>
X-Attachment-Id: f_mioqs0ec0

CldlZCBTZXAgIDMgMDk6MTU6NTMgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IENoID0g
ICAxIGludGVyZmVyZW5jZS1mYWN0b3IgPSAwLjc3ODc1OSAKV2VkIFNlcCAgMyAwOToxNTo1MyAy
MDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogQ2ggPSAgIDIgaW50ZXJmZXJlbmNlLWZhY3Rv
ciA9IDAuNTUyNzk1IApXZWQgU2VwICAzIDA5OjE1OjUzIDIwMjUgZGFlbW9uLmluZm8gY3Ntbmdy
OiBwaHkwOiBDaCA9ICAgMyBpbnRlcmZlcmVuY2UtZmFjdG9yID0gMC4zMjkyNjggCldlZCBTZXAg
IDMgMDk6MTU6NTMgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IENoID0gICA0IGludGVy
ZmVyZW5jZS1mYWN0b3IgPSAwLjQ2NzAwNSAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRhZW1v
bi5pbmZvIGNzbW5ncjogcGh5MDogQ2ggPSAgIDUgaW50ZXJmZXJlbmNlLWZhY3RvciA9IDAuNjY1
MDcyIApXZWQgU2VwICAzIDA5OjE1OjUzIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBD
aCA9ICAgNiBpbnRlcmZlcmVuY2UtZmFjdG9yID0gMC44ODk1MDMgCldlZCBTZXAgIDMgMDk6MTU6
NTMgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IENoID0gICA3IGludGVyZmVyZW5jZS1m
YWN0b3IgPSAwLjQxMDI1NiAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRhZW1vbi5pbmZvIGNz
bW5ncjogcGh5MDogQ2ggPSAgIDggaW50ZXJmZXJlbmNlLWZhY3RvciA9IDAuNDUxNzc3IApXZWQg
U2VwICAzIDA5OjE1OjUzIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBDaCA9ICAgOSBp
bnRlcmZlcmVuY2UtZmFjdG9yID0gMC4xMjUgCldlZCBTZXAgIDMgMDk6MTU6NTMgMjAyNSBkYWVt
b24uaW5mbyBjc21uZ3I6IHBoeTA6IENoID0gIDEwIGludGVyZmVyZW5jZS1mYWN0b3IgPSAwLjQ4
NzY1NCAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDog
Q2ggPSAgMTEgaW50ZXJmZXJlbmNlLWZhY3RvciA9IDAuNzM5Mzk0IApXZWQgU2VwICAzIDA5OjE1
OjUzIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBDaCA9ICAxMiBpbnRlcmZlcmVuY2Ut
ZmFjdG9yID0gMC40NTQwODIgCldlZCBTZXAgIDMgMDk6MTU6NTMgMjAyNSBkYWVtb24uaW5mbyBj
c21uZ3I6IHBoeTA6IENoID0gIDEzIGludGVyZmVyZW5jZS1mYWN0b3IgPSAwLjA5NDY3NDYgCldl
ZCBTZXAgIDMgMDk6MTU6NTMgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IENoYW5uZWwg
MTMgaGFzIGxvd2VzdCBpbnRlcmZlcmVuY2UtZmFjdG9yIDAuMDk0Njc0NiAKV2VkIFNlcCAgMyAw
OToxNTo1MyAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogQ2ggPSAxIE9CU1MgPSA0NyAK
V2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogcHJlZmVy
IGNoYW5uZWxzIDEsNiBvciAxMTsgc2tpcCAyIApXZWQgU2VwICAzIDA5OjE1OjUzIDIwMjUgZGFl
bW9uLmluZm8gY3NtbmdyOiBwaHkwOiBwcmVmZXIgY2hhbm5lbHMgMSw2IG9yIDExOyBza2lwIDMg
CldlZCBTZXAgIDMgMDk6MTU6NTMgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IHByZWZl
ciBjaGFubmVscyAxLDYgb3IgMTE7IHNraXAgNCAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRh
ZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogcHJlZmVyIGNoYW5uZWxzIDEsNiBvciAxMTsgc2tpcCA1
IApXZWQgU2VwICAzIDA5OjE1OjUzIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBDaCA9
IDYgT0JTUyA9IDExIApXZWQgU2VwICAzIDA5OjE1OjUzIDIwMjUgZGFlbW9uLmluZm8gY3Ntbmdy
OiBwaHkwOiBwcmVmZXIgY2hhbm5lbHMgMSw2IG9yIDExOyBza2lwIDcgCldlZCBTZXAgIDMgMDk6
MTU6NTMgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IHByZWZlciBjaGFubmVscyAxLDYg
b3IgMTE7IHNraXAgOCAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRhZW1vbi5pbmZvIGNzbW5n
cjogcGh5MDogcHJlZmVyIGNoYW5uZWxzIDEsNiBvciAxMTsgc2tpcCA5IApXZWQgU2VwICAzIDA5
OjE1OjUzIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBwcmVmZXIgY2hhbm5lbHMgMSw2
IG9yIDExOyBza2lwIDEwIApXZWQgU2VwICAzIDA5OjE1OjUzIDIwMjUgZGFlbW9uLmluZm8gY3Nt
bmdyOiBwaHkwOiBDaCA9IDExIE9CU1MgPSAxMiAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRh
ZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogcHJlZmVyIGNoYW5uZWxzIDEsNiBvciAxMTsgc2tpcCAx
MiAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogcHJl
ZmVyIGNoYW5uZWxzIDEsNiBvciAxMTsgc2tpcCAxMyAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1
IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogc2tpcCA0ME1IeiBiYW5kd2lkdGggb3BjbGFzcyBp
biAyLjRHSHogCldlZCBTZXAgIDMgMDk6MTU6NTMgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBo
eTA6IHNraXAgNDBNSHogYmFuZHdpZHRoIG9wY2xhc3MgaW4gMi40R0h6IApXZWQgU2VwICAzIDA5
OjE1OjUzIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBjaGFubmVsID0gICAxLCBidyA9
ICAyMCwgU0NPUkUgPSAxNS40NjczIApXZWQgU2VwICAzIDA5OjE1OjUzIDIwMjUgZGFlbW9uLmlu
Zm8gY3NtbmdyOiBwaHkwOiBjaGFubmVsID0gICA2LCBidyA9ICAyMCwgU0NPUkUgPSA0LjUzMzcg
CldlZCBTZXAgIDMgMDk6MTU6NTMgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IGNoYW5u
ZWwgPSAgMTEsIGJ3ID0gIDIwLCBTQ09SRSA9IDQuNDQzNjQgCldlZCBTZXAgIDMgMDk6MTU6NTMg
MjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IEJFU1QgKCAyMCBNSHopOiBPcGNsYXNzOiA4
MSAgY3RybC1jaGFubmVsID0gMTEgIHNjb3JlID0gNC40NDM2NCAKV2VkIFNlcCAgMyAwOToxNTo1
MyAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogU2V0IE9QVElNQUwgY2hhbm5lbCAxMSAo
IDIwIE1IeikgaW4gb3BjbGFzcyA4MSAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRhZW1vbi5p
bmZvIGNzbW5ncjogd2lmaV9jaGFuX3N3aXRjaCh3bGFuMC40KTogZnJlcSA9IDI0NjIsIHNjbyA9
IDAsIGVodCA9IDAsIGhlID0gMSwgdmh0ID0gMCwgaHQgPSAxIApXZWQgU2VwICAzIDA5OjE1OjUz
IDIwMjUgZGFlbW9uLmluZm8gaG9zdGFwZDogd2xhbjA6IElFRUUgODAyLjExIENIQU5fU1dJVENI
IEVIVCBjb25maWcgMHgyIEhFIGNvbmZpZyAweDEgVkhUIGNvbmZpZyAweDIKV2VkIFNlcCAgMyAw
OToxNTo1MyAyMDI1IGRhZW1vbi5pbmZvIGhvc3RhcGQ6IHdsYW4wLjQ6IElFRUUgODAyLjExIENI
QU5fU1dJVENIIEVIVCBjb25maWcgMHgyIEhFIGNvbmZpZyAweDEgVkhUIGNvbmZpZyAweDIKV2Vk
IFNlcCAgMyAwOToxNTo1MyAyMDI1IGRhZW1vbi5pbmZvIGhvc3RhcGQ6IHdsYW4wOiBJRUVFIDgw
Mi4xMSBkcml2ZXIgc3RhcnRpbmcgY2hhbm5lbCBzd2l0Y2g6IGlmYWNlLT5mcmVxPTI0MTIsIGZy
ZXE9MjQ2MiwgaHQ9MSwgdmh0X2NoPTB4MiwgaGVfY2g9MHgxLCBlaHRfY2g9MHgyLCBvZmZzZXQ9
MCwgd2lkdGg9MSAoMjAgTUh6KSwgY2YxPTI0NjIsIGNmMj0wLCBwdW5jdHVyaW5nX2JpdG1hcD0w
eDAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRhZW1vbi5ub3RpY2UgaG9zdGFwZDogd2xhbjA6
IENUUkwtRVZFTlQtU1RBUlRFRC1DSEFOTkVMLVNXSVRDSCBmcmVxPTI0NjIgaHRfZW5hYmxlZD0x
IGNoX29mZnNldD0wIGNoX3dpZHRoPTIwIE1IeiBjZjE9MjQ2MiBjZjI9MCBpc19kZnMwPTAgZGZz
PTAgcHVuY3R1cmluZ19iaXRtYXA9MHgwMDAwCldlZCBTZXAgIDMgMDk6MTU6NTMgMjAyNSBkYWVt
b24uaW5mbyBob3N0YXBkOiB3bGFuMC40OiBJRUVFIDgwMi4xMSBkcml2ZXIgc3RhcnRpbmcgY2hh
bm5lbCBzd2l0Y2g6IGlmYWNlLT5mcmVxPTI0NjIsIGZyZXE9MjQ2MiwgaHQ9MSwgdmh0X2NoPTB4
MCwgaGVfY2g9MHgwLCBlaHRfY2g9MHgwLCBvZmZzZXQ9MCwgd2lkdGg9MSAoMjAgTUh6KSwgY2Yx
PTI0NjIsIGNmMj0wLCBwdW5jdHVyaW5nX2JpdG1hcD0weDAKV2VkIFNlcCAgMyAwOToxNTo1MyAy
MDI1IGRhZW1vbi5ub3RpY2UgaG9zdGFwZDogd2xhbjAuNDogQ1RSTC1FVkVOVC1TVEFSVEVELUNI
QU5ORUwtU1dJVENIIGZyZXE9MjQ2MiBodF9lbmFibGVkPTEgY2hfb2Zmc2V0PTAgY2hfd2lkdGg9
MjAgTUh6IGNmMT0yNDYyIGNmMj0wIGlzX2RmczA9MCBkZnM9MCBwdW5jdHVyaW5nX2JpdG1hcD0w
eDAwMDAKV2VkIFNlcCAgMyAwOToxNTo1MyAyMDI1IGRhZW1vbi53YXJuIG9kaGNwZFs4MDc4XTog
Tm8gZGVmYXVsdCByb3V0ZSBwcmVzZW50LCBvdmVycmlkaW5nIHJhX2xpZmV0aW1lIHRvIDAhCldl
ZCBTZXAgIDMgMDk6MTU6NTMgMjAyNSBkYWVtb24uZXJyIGhvc3RhcGQ6IENhbm5vdCBzZXQgYmVh
Y29ucyBkdXJpbmcgQ1NBIHBlcmlvZApbMzg4OTkzLjE5MDcwOF0gVW5hYmxlIHRvIGhhbmRsZSBr
ZXJuZWwgcmVhZCBmcm9tIHVucmVhZGFibGUgbWVtb3J5IGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAw
MDAwMDAwMDAwMDAwClszODg5OTMuMTk5OTU0XSBNZW0gYWJvcnQgaW5mbzoKWzM4ODk5My4yMDI4
NjldICAgRVNSID0gMHgwMDAwMDAwMDk2MDAwMDA1ClszODg5OTMuMjA2NzU1XSAgIEVDID0gMHgy
NTogREFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0cwpXZWQgU2VwICAzIDA5OjE1WzM4ODk5
My4yMTIxNDVdICAgU0VUID0gMCwgRm5WID0gMAo6NTMgMjAyNSBrZXJuLmFsWzM4ODk5My4yMTY3
NjJdICAgRUEgPSAwLCBTMVBUVyA9IDAKZXJ0IGtlcm5lbDogWzM4OFszODg5OTMuMjIxMzQ1XSAg
IEZTQyA9IDB4MDU6IGxldmVsIDEgdHJhbnNsYXRpb24gZmF1bHQKOTkzLjE5MDcwOF0gVW5hYlsz
ODg5OTMuMjI3NjkzXSBEYXRhIGFib3J0IGluZm86CmxlIHRvIGhhbmRsZSBrZXJbMzg4OTkzLjIz
MjAzNl0gICBJU1YgPSAwLCBJU1MgPSAweDAwMDAwMDA1LCBJU1MyID0gMHgwMDAwMDAwMApuZWwg
cmVhZCBmcm9tIHVuWzM4ODk5My4yMzkwMDJdICAgQ00gPSAwLCBXblIgPSAwLCBUbkQgPSAwLCBU
YWdBY2Nlc3MgPSAwCnJlYWRhYmxlIG1lbW9yeSBbMzg4OTkzLjI0NTU2NF0gICBHQ1MgPSAwLCBP
dmVybGF5ID0gMCwgRGlydHlCaXQgPSAwLCBYcyA9IDAKYXQgdmlydHVhbCBhZGRyZVszODg5OTMu
MjUyMzM3XSB1c2VyIHBndGFibGU6IDRrIHBhZ2VzLCAzOS1iaXQgVkFzLCBwZ2RwPTAwMDAwMDAw
NGRkOTAwMDAKc3MgMDAwMDAwMDAwMDAwMFszODg5OTMuMjYwMjM3XSBbMDAwMDAwMDAwMDAwMDAw
MF0gcGdkPTAwMDAwMDAwMDAwMDAwMDAsIHA0ZD0wMDAwMDAwMDAwMDAwMDAwLCBwdWQ9MDAwMDAw
MDAwMDAwMDAwMAowMDAKV2VkIFNlcCAgMyBbMzg4OTkzLjI3MDQyNF0gSW50ZXJuYWwgZXJyb3I6
IE9vcHM6IDAwMDAwMDAwOTYwMDAwMDUgWyMxXSBTTVAKWzM4ODk5My4yNzc0MTZdIE1vZHVsZXMg
bGlua2VkIGluOiBwcHBvZSBuZl9mbG93X3RhYmxlX2luZXQgbXQ3OTE1ZShPKSBtdDc2X2Nvbm5h
Y19saWIoTykgbXQ3NihPKSBtYWM4MDIxMShPKSBsMnRwX3BwcCBpcHRfUkVKRUNUIGVidGFibGVf
bmF0IGVidGFibGVfZmlsdGVyIGVidGFibGVfYnJvdXRlIGNmZzgwMjExKE8pIHh0X3RpbWUgeHRf
dGNwdWRwIHh0X3RjcG1zcyB4dF9zdHJpbmcgeHRfc3RhdGlzdGljIHh0X3N0YXRlIHh0X3JlY2Vu
dCB4dF9xdW90YSB4dF9wa3R0eXBlIHh0Cl9vd25lciB4dF9uYXQgeHRfbXVsdGlwb3J0IHh0X21h
cmsgeHRfbWFjIHh0X2xpbWl0IHh0X2xlbmd0aCB4dF9pcHJhbmdlIHh0X2hsIHh0X2hlbHBlciB4
dF9lY24geHRfZHNjcCB4dF9jb25udHJhY2sgeHRfY29ubm1hcmsgeHRfY29ubmxpbWl0IHh0X2Nv
bm5ieXRlcyB4dF9jb21tZW50IHh0X2Nncm91cCB4dF9icGYgeHRfYWRkcnR5cGUgeHRfVENQTVNT
IHh0X1JFRElSRUNUIHh0X05GUVVFVUUgeHRfTkZMT0cgeHRfTUFTUVVFUkFERSB4dF9MT0cgeHRf
SVBNQVJLKE8pIHh0X0hMIAp4dF9GTE9XT0ZGTE9BRCB4dF9EU0NQIHh0X0NUIHh0X0NMQVNTSUZZ
IHRzX2ZzbSB0c19ibSBzZnAgcHB0cCBwcHBveCBwcHBfbXBwZSBwcHBfYXN5bmMgbmZ0X3JlamVj
dF9pcHY2IG5mdF9yZWplY3RfaXB2NCBuZnRfcmVqZWN0X2luZXQgbmZ0X3JlamVjdCBuZnRfcmVk
aXIgbmZ0X3F1b3RhIG5mdF9udW1nZW4gbmZ0X25hdCBuZnRfbWFzcSBuZnRfbG9nIG5mdF9saW1p
dCBuZnRfaGFzaCBuZnRfZmxvd19vZmZsb2FkIG5mdF9jdCBuZnRfY2hhaW5fbmF0IG5mbmV0bGlu
a19xdWV1ZSAKbmZuZXRsaW5rX2xvZyBuZl90YWJsZXMgbmZfcmVqZWN0X2lwdjQgbmZfbmF0X3Rm
dHAgbmZfbmF0X3NubXBfYmFzaWMgbmZfbmF0X3BwdHAgbmZfbmF0X2lyYyBuZl9uYXRfaDMyMyBu
Zl9uYXRfZnRwIG5mX25hdF9hbWFuZGEgbmZfbG9nX3N5c2xvZyBuZl9mbG93X3RhYmxlIG5mX2Nv
bm50cmFja190ZnRwIG5mX2Nvbm50cmFja19zbm1wIG5mX2Nvbm50cmFja19zaXAKMDk6MTU6NTMg
MjAyNSBrZVszODg5OTMuMjc3NTk5XSAgbmZfY29ubnRyYWNrX3NhbmUgbmZfY29ubnRyYWNrX3Bw
dHAgbmZfY29ubnRyYWNrX25ldGxpbmsgbmZfY29ubnRyYWNrX25ldGJpb3NfbnMgbmZfY29ubnRy
YWNrX2lyYyBuZl9jb25udHJhY2tfaDMyMyBuZl9jb25udHJhY2tfZnRwIG5mX2Nvbm50cmFja19i
cm9hZGNhc3QgdHNfa21wIG5mX2Nvbm50cmFja19hbWFuZGEgbmZfY29ubmNvdW50IG1kaW9faTJj
IGxpYmNyYzMyYyBpcHRhYmxlX3JhdyBpcHRhYmxlX25hdCBpcHRhCmJsZV9tYW5nbGUgaXB0YWJs
ZV9maWx0ZXIgaXB0X0VDTiBpcF90YWJsZXMgaGlkX2dlbmVyaWMgZWJ0YWJsZXMgZWJ0X3ZsYW4g
ZWJ0X3N0cCBlYnRfcmVkaXJlY3QgZWJ0X3BrdHR5cGUgZWJ0X21hcmtfbSBlYnRfbWFyayBlYnRf
bGltaXQgZWJ0X2Ftb25nIGVidF84MDJfMyBjb21wYXRfeHRhYmxlcyhPKSBjb21wYXQoTykgYXNu
MV9kZWNvZGVyIGNyeXB0b19zYWZleGNlbCBzY2hfdGJmIHNjaF9pbmdyZXNzIHNjaF9odGIgc2No
X2hmc2MgZW1fdTMyIGNsc191MzIgY2xzX3JvdXRlIApjbHNfbWF0Y2hhbGwgY2xzX2Z3IGNsc19m
bG93IGNsc19iYXNpYyBhY3Rfc2tiZWRpdCBhY3RfbWlycmVkIGFjdF9nYWN0IGNvbmZpZ3MgaGlk
IGV2ZGV2IHB3bV9mYW4gaTJjX2dwaW8gaTJjX2FsZ29fYml0IHh0X3NldCBpcF9zZXRfbGlzdF9z
ZXQgaXBfc2V0X2hhc2hfbmV0cG9ydG5ldCBpcF9zZXRfaGFzaF9uZXRwb3J0IGlwX3NldF9oYXNo
X25ldG5ldCBpcF9zZXRfaGFzaF9uZXRpZmFjZSBpcF9zZXRfaGFzaF9uZXQgaXBfc2V0X2hhc2hf
bWFjIGlwX3NldF9oYXNoX2lwcG9ydG4KZXQgaXBfc2V0X2hhc2hfaXBwb3J0aXAgaXBfc2V0X2hh
c2hfaXBwb3J0IGlwX3NldF9oYXNoX2lwbWFyayBpcF9zZXRfaGFzaF9pcG1hYyBpcF9zZXRfaGFz
aF9pcCBpcF9zZXRfYml0bWFwX3BvcnQgaXBfc2V0X2JpdG1hcF9pcG1hYyBpcF9zZXRfYml0bWFw
X2lwIGlwX3NldCBuZm5ldGxpbmsgaXA2dGFibGVfbWFuZ2xlIGlwNnRhYmxlX2ZpbHRlciBpcDZf
dGFibGVzIGlwNnRfUkVKRUNUClszODg5OTMuMzY3Nzk5XSAgbmZfcmVqZWN0X2lwdjYgc3djb25m
aWcgcHBwb2F0bSBwcHBfZ2VuZXJpYyBzbGhjIGlwNl9ncmUgaXBfZ3JlIGdyZSBuYXQ0NihPKSBz
aXQgbDJ0cF9uZXRsaW5rIGwydHBfY29yZSB1ZHBfdHVubmVsIGlwNl91ZHBfdHVubmVsIGlwNl90
dW5uZWwgdHVubmVsNiB0dW5uZWw0IGlwX3R1bm5lbCBlYnRfeHRpcDYoTykgZWJ0X3h0aXAoTykg
ZWJ0X3h0YXJwKE8pIGVidF92bGFudHJhbnNsYXRpb24oTykgdmV0aCBlYnRfcmEoTykgZWJ0X3Bw
cG9lX2Rpc2MoTwopIGVidF9kc2NwMnBiaXQoTykgZWJ0X2RucyhPKSBlYnRfZGhjcHY2KE8pIGVi
dF9kaGNwKE8pIGJyMjY4NCBhdG0gY3J5cHRvX3VzZXIgYWxnaWZfc2tjaXBoZXIgYWxnaWZfcm5n
IGFsZ2lmX2hhc2ggYWxnaWZfYWVhZCBhZl9hbGcgc2hhNTEyX2FybTY0IHNoYTFfY2Ugc2hhMV9n
ZW5lcmljIHNlcWl2IG1kNSBnZW5pdiBkZXNfZ2VuZXJpYyBsaWJkZXMgY2JjIGF1dGhlbmNlc24g
YXV0aGVuYyBhcmM0IGdwaW9fa2V5cyBsZWRzX2dwaW8geGhjaV9wbGF0X2hjZCB4aGNpX3BjaSB4
aGMKaV9tdGtfaGNkIHhoY2lfaGNkIGFoY2kgbGliYWhjaSBpcHRfVFJJR0dFUihPKSBpcDZ0X1RS
SUdHRVIoTykgbmZfbmF0IG5mX2Nvbm50cmFjayB4X3RhYmxlcyBuZl9kZWZyYWdfaXB2NiBuZl9k
ZWZyYWdfaXB2NCBkbV9taXJyb3IgZG1fcmVnaW9uX2hhc2ggZG1fbG9nIGRtX2NyeXB0IGRtX21v
ZCBkYXggYnV0dG9uX2hvdHBsdWcoTykgaW5wdXRfY29yZSB1c2Jjb3JlIHVzYl9jb21tb24gYXF1
YW50aWEgdHBtIGVuY3J5cHRlZF9rZXlzIHRydXN0ZWQKWzM4ODk5My41MjkyNTVdIENQVTogMCBQ
SUQ6IDE1MDExIENvbW06IGt3b3JrZXIvdTg6MSBUYWludGVkOiBHICAgICAgICAgICBPICAgICAg
IDYuNi43MyAjMApbMzg4OTkzLjUzNzMyN10gSGFyZHdhcmUgbmFtZTogQmFuYW5hcGkgQlBJLVIz
IChEVCkKWzM4ODk5My41NDE5MjhdIFdvcmtxdWV1ZTogZXZlbnRzX3VuYm91bmQgd2lwaHlfZGVs
YXllZF93b3JrX3BlbmRpbmcgW2NmZzgwMjExXQpbMzg4OTkzLjU0ODk4OV0gcHN0YXRlOiAyMDQw
MDAwNSAobnpDdiBkYWlmICtQQU4gLVVBTyAtVENPIC1ESVQgLVNTQlMgQlRZUEU9LS0pClszODg5
OTMuNTU2MDE4XSBwYyA6IF9pZWVlODAyMTFfc3RhX2NhcF9yeF9idysweDE0LzB4Y2MgW21hYzgw
MjExXQpbMzg4OTkzLjU2MTk1OV0gbHIgOiBfaWVlZTgwMjExX3N0YV9jdXJfdmh0X2J3KzB4MjAv
MHhhNCBbbWFjODAyMTFdClszODg5OTMuNTY3OTc2XSBzcCA6IGZmZmZmZmMwODcwM2JjMDAKWzM4
ODk5My41NzEzNjNdIHgyOTogZmZmZmZmYzA4NzAzYmMwMCB4Mjg6IGZmZmZmZjgwMDc1ODI2Nzgg
eDI3OiBmZmZmZmY4MDA2YjQyMWIwClszODg5OTMuNTc4NTcxXSB4MjY6IGZmZmZmZjgwMDZiNDBm
MDggeDI1OiBmZmZmZmY4MDA2YjQwOGMwIHgyNDogMDAwMDAwMDAwMDAwMDAwMQpybi5hbGVydCBr
ZXJuZWw6WzM4ODk5My41ODU3NzZdIHgyMzogMDAwMDAwMDAwMDAwMDAwMSB4MjI6IGZmZmZmZjgw
MDBkZjhlYTAgeDIxOiBmZmZmZmY4MDA3NTgyMDAwClszODg5OTMuNTk0MzYwXSB4MjA6IGZmZmZm
ZjgwMGM3Mjg5MDAgeDE5OiAwMDAwMDAwMDAwMDAwMDAwIHgxODogZmZmZmZmZmZmZmZmYzgzOApb
Mzg4OTkzLjYwMTU2NV0geDE3OiBmZmZmZmZiZmZlZmQyMDAwIHgxNjogZmZmZmZmYzA4MDAwMDAw
MCB4MTU6IDAwMDAwMDAwMDAwMDAwMDAKWzM4ODk5My42MDg3NzBdIHgxNDogMDAwMDAwMDAwMDAw
MDAwMCB4MTM6IDAwMDAwMDAwMDAwMDAwMzAgeDEyOiAwMTAxMDEwMTAxMDEwMTAxClszODg5OTMu
NjE1OTc1XSB4MTE6IDdmN2Y3ZjdmN2Y3ZjdmN2YgeDEwOiBmZWZmNjM2ZDc0NmU2MTZkIHg5IDog
N2Y3ZjdmN2Y3ZjdmN2Y3ZgpbMzg4OTkzLjYyMzE4MF0geDggOiAwMDAwMDAwMDAwMDAwMDAyIHg3
IDogMDAwMDAwMDAwMDAwMDAwMiB4NiA6IDAwMDAwMDAwMDAwMDAwMDAKWzM4ODk5My42MzAzODRd
IHg1IDogZmZmZmZmODAwNzU4MjAwMCB4NCA6IGZmZmZmZjgwMDc1ODI2NzggeDMgOiAwMDAwMDAw
MDAwMDAwMDAxClszODg5OTMuNjM3NTg3XSB4MiA6IGZmZmZmZjgwMDc1ODJiNTggeDEgOiBmZmZm
ZmY4MDBjNzI5ODE4IHgwIDogMDAwMDAwMDAwMDAwMDAwMApbMzg4OTkzLjY0NDc5M10gQ2FsbCB0
cmFjZToKWzM4ODk5My42NDczMTNdICBfaWVlZTgwMjExX3N0YV9jYXBfcnhfYncrMHgxNC8weGNj
IFttYWM4MDIxMV0KWzM4ODk5My42NTI5MDFdICBpZWVlODAyMTFfaXRlcl9jaGFuX2NvbnRleHRz
X2F0b21pYysweDI2MC8weGYzYyBbbWFjODAyMTFdClszODg5OTMuNjU5NjEzXSAgaWVlZTgwMjEx
X2xpbmtfdW5yZXNlcnZlX2NoYW5jdHgrMHg0MjQvMHhhYWMgW21hYzgwMjExXQpbMzg4OTkzLjY2
NjA3Ml0gIGllZWU4MDIxMV9saW5rX3VzZV9yZXNlcnZlZF9jb250ZXh0KzB4YWMvMHhmNCBbbWFj
ODAyMTFdClszODg5OTMuNjcyNjA4XSAgaWVlZTgwMjExX25hbl9mdW5jX3Rlcm1pbmF0ZWQrMHgz
ZTEwLzB4NGQxMCBbbWFjODAyMTFdClszODg5OTMuNjc4OTc5XSAgaWVlZTgwMjExX2NzYV9maW5h
bGl6ZV93b3JrKzB4MmMvMHgzNCBbbWFjODAyMTFdClszODg5OTMuNjg0ODI4XSAgd2lwaHlfZGVs
YXllZF93b3JrX3BlbmRpbmcrMHgyYTQvMHgzYzggW2NmZzgwMjExXQpbMzg4OTkzLjY5MDc1NF0g
IHByb2Nlc3Nfb25lX3dvcmsrMHgxNzgvMHgyZjAKWzM4ODk5My42OTQ4NDVdICB3b3JrZXJfdGhy
ZWFkKzB4MmU0LzB4NGNjClszODg5OTMuNjk4NjcwXSAga3RocmVhZCsweGQ4LzB4ZGMKWzM4ODk5
My43MDE4MDNdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMApbMzg4OTkzLjcwNTQ1OV0gQ29kZTog
Mzk0MTUwNDMgMzYwMDAxYTMgYjQwMDA0NDEgZjk0MDAwMjAgKGI5NDAwMDAwKSAKWzM4ODk5My43
MTE2MjJdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQpbMzg4OTkzLjcyMzQ4
MV0gcHN0b3JlOiBiYWNrZW5kIChyYW1vb3BzKSB3cml0aW5nIGVycm9yICgtMjgpClszODg5OTMu
NzI4OTU2XSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogT29wczogRmF0YWwgZXhjZXB0aW9u
ClszODg5OTMuNzM0NzY5XSBTTVA6IHN0b3BwaW5nIHNlY29uZGFyeSBDUFVzClszODg5OTMuNzM4
NzY3XSBLZXJuZWwgT2Zmc2V0OiBkaXNhYmxlZApbMzg4OTkzLjc0MjMyNl0gQ1BVIGZlYXR1cmVz
OiAweDAsMDAwMDAwMDAsMDAwMDAwMDAsMTAwMDQwMGIKWzM4ODk5My43NDc3MDhdIE1lbW9yeSBM
aW1pdDogbm9uZQpbMzg4OTkzLjc1NzM0Ml0gUmVib290aW5nIGluIDMgc2Vjb25kcy4uCgoK
--00000000000034a93c0644fa0334
Content-Type: text/x-patch; charset=WINDOWS-1252; 
	name=342-wifi-mac80211-fix-reserved-chan.patch
Content-Disposition: attachment; 
	filename="342-wifi-mac80211-fix-reserved-chan.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mioqs5a21>
X-Attachment-Id: f_mioqs5a21

ZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS9jaGFuLmMgYi9uZXQvbWFjODAyMTEvY2hhbi5jCmlu
ZGV4IGNjYTZkMTQwODRkMi4uZGRkMTkxOGFhZmMwIDEwMDY0NAotLS0gYS9uZXQvbWFjODAyMTEv
Y2hhbi5jCisrKyBiL25ldC9tYWM4MDIxMS9jaGFuLmMKQEAgLTQ0OSw4ICs0NDksMTMgQEAgc3Rh
dGljIHZvaWQgaWVlZTgwMjExX2NoYW5fYndfY2hhbmdlKHN0cnVjdCBpZWVlODAyMTFfbG9jYWwg
KmxvY2FsLAogCQkJaWYgKCFsaW5rX3N0YSkKIAkJCQljb250aW51ZTsKIAotCQkJaWYgKHJlc2Vy
dmVkKQorCQkJaWYgKHJlc2VydmVkKSB7CiAJCQkJbmV3X2NoYW5kZWYgPSAmbGluay0+cmVzZXJ2
ZWQub3BlcjsKKwkJCQlpZiAoV0FSTighbmV3X2NoYW5kZWYtPmNoYW4sCisJCQkJCSAiTlVMTCBk
ZXJlZmVyZW5jZSBjcmFzaCBwcm90ZWN0aW9uIHJlc2VydmVkIG5ld19jaGFuZGVmLT5jaGFuID0g
JXBcbiIsCisJCQkJCSBuZXdfY2hhbmRlZi0+Y2hhbikpCisJCQkJCW5ld19jaGFuZGVmID0gJmxp
bmtfY29uZi0+Y2hhbnJlcS5vcGVyOworCQkJfQogCQkJZWxzZQogCQkJCW5ld19jaGFuZGVmID0g
JmxpbmtfY29uZi0+Y2hhbnJlcS5vcGVyOwogCg==
--00000000000034a93c0644fa0334
Content-Type: text/plain; charset=WINDOWS-1252; 
	name=BPI3_hub_chan_switch_crash_protection.txt
Content-Disposition: attachment; 
	filename="BPI3_hub_chan_switch_crash_protection.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mioqsav82>
X-Attachment-Id: f_mioqsav82

cm9vdEAwMDAwMDAwMDAwOn4jIApyb290QDAwMDAwMDAwMDA6fiMgCnJvb3RAMDAwMDAwMDAwMDp+
IyBpd2luZm8Kd2xhbjAgICAgIEVTU0lEOiAiR2xvYmFsTG9naWMgRGVtbyIKICAgICAgICAgIEFj
Y2VzcyBQb2ludDogMDA6MEM6NDM6MjY6NjA6MDAKICAgICAgICAgIE1vZGU6IE1hc3RlciAgQ2hh
bm5lbDogMSAoMi40MTIgR0h6KSAgSFQgTW9kZTogSEUyMAogICAgICAgICAgQ2VudGVyIENoYW5u
ZWwgMTogMSAyOiB1bmtub3duCiAgICAgICAgICBUeC1Qb3dlcjogNCBkQm0gIExpbmsgUXVhbGl0
eTogdW5rbm93bi83MAogICAgICAgICAgU2lnbmFsOiB1bmtub3duICBOb2lzZTogLTkwIGRCbQog
ICAgICAgICAgQml0IFJhdGU6IHVua25vd24KICAgICAgICAgIEVuY3J5cHRpb246IG1peGVkIFdQ
QTIvV1BBMyBQU0svU0FFIChDQ01QKQogICAgICAgICAgVHlwZTogbmw4MDIxMSAgSFcgTW9kZShz
KTogODAyLjExYXgvYi9nL24KICAgICAgICAgIEhhcmR3YXJlOiBlbWJlZGRlZCBbTWVkaWFUZWsg
TVQ3OTg2XQogICAgICAgICAgVFggcG93ZXIgb2Zmc2V0OiBub25lCiAgICAgICAgICBGcmVxdWVu
Y3kgb2Zmc2V0OiBub25lCiAgICAgICAgICBTdXBwb3J0cyBWQVBzOiB5ZXMgIFBIWSBuYW1lOiBw
aHkwCgp3bGFuMC40ICAgRVNTSUQ6ICJCSC03MkMyMkQ1NEFCNkYiCiAgICAgICAgICBBY2Nlc3Mg
UG9pbnQ6IDAyOjBDOjQzOjI2OjYwOjAwCiAgICAgICAgICBNb2RlOiBNYXN0ZXIgIENoYW5uZWw6
IDEgKDIuNDEyIEdIeikgIEhUIE1vZGU6IEhFMjAKICAgICAgICAgIENlbnRlciBDaGFubmVsIDE6
IDEgMjogdW5rbm93bgogICAgICAgICAgVHgtUG93ZXI6IDQgZEJtICBMaW5rIFF1YWxpdHk6IDY1
LzcwCiAgICAgICAgICBTaWduYWw6IC00NSBkQm0gIE5vaXNlOiAtOTAgZEJtCiAgICAgICAgICBC
aXQgUmF0ZTogMjMyLjMgTUJpdC9zCiAgICAgICAgICBFbmNyeXB0aW9uOiBXUEEzIFNBRSAoQ0NN
UCkKICAgICAgICAgIFR5cGU6IG5sODAyMTEgIEhXIE1vZGUocyk6IDgwMi4xMWF4L2IvZy9uCiAg
ICAgICAgICBIYXJkd2FyZTogZW1iZWRkZWQgW01lZGlhVGVrIE1UNzk4Nl0KICAgICAgICAgIFRY
IHBvd2VyIG9mZnNldDogbm9uZQogICAgICAgICAgRnJlcXVlbmN5IG9mZnNldDogbm9uZQogICAg
ICAgICAgU3VwcG9ydHMgVkFQczogeWVzICBQSFkgbmFtZTogcGh5MAoKd2xhbjAuNC5zdGExIEVT
U0lEOiB1bmtub3duCiAgICAgICAgICBBY2Nlc3MgUG9pbnQ6IDAyOjBDOjQzOjI2OjYwOjAwCiAg
ICAgICAgICBNb2RlOiBNYXN0ZXIgKFZMQU4pICBDaGFubmVsOiAxICgyLjQxMiBHSHopICBIVCBN
b2RlOiBIRTIwCiAgICAgICAgICBDZW50ZXIgQ2hhbm5lbCAxOiAxIDI6IHVua25vd24KICAgICAg
ICAgIFR4LVBvd2VyOiA0IGRCbSAgTGluayBRdWFsaXR5OiA2NS83MAogICAgICAgICAgU2lnbmFs
OiAtNDUgZEJtICBOb2lzZTogLTkwIGRCbQogICAgICAgICAgQml0IFJhdGU6IDIzMi4zIE1CaXQv
cwogICAgICAgICAgRW5jcnlwdGlvbjogdW5rbm93bgogICAgICAgICAgVHlwZTogbmw4MDIxMSAg
SFcgTW9kZShzKTogODAyLjExYXgvYi9nL24KICAgICAgICAgIEhhcmR3YXJlOiBlbWJlZGRlZCBb
TWVkaWFUZWsgTVQ3OTg2XQogICAgICAgICAgVFggcG93ZXIgb2Zmc2V0OiBub25lCiAgICAgICAg
ICBGcmVxdWVuY3kgb2Zmc2V0OiBub25lCiAgICAgICAgICBTdXBwb3J0cyBWQVBzOiB5ZXMgIFBI
WSBuYW1lOiBwaHkwCgp3bGFuMSAgICAgRVNTSUQ6ICJHbG9iYWxMb2dpYyBEZW1vIgogICAgICAg
ICAgQWNjZXNzIFBvaW50OiA4MjowQzo0MzoyNjo2MDowMAogICAgICAgICAgTW9kZTogTWFzdGVy
ICBDaGFubmVsOiAzNiAoNS4xODAgR0h6KSAgSFQgTW9kZTogSEU4MAogICAgICAgICAgQ2VudGVy
IENoYW5uZWwgMTogNDIgMjogdW5rbm93bgogICAgICAgICAgVHgtUG93ZXI6IDQgZEJtICBMaW5r
IFF1YWxpdHk6IHVua25vd24vNzAKICAgICAgICAgIFNpZ25hbDogdW5rbm93biAgTm9pc2U6IC05
MiBkQm0KICAgICAgICAgIEJpdCBSYXRlOiB1bmtub3duCiAgICAgICAgICBFbmNyeXB0aW9uOiBt
aXhlZCBXUEEyL1dQQTMgUFNLL1NBRSAoQ0NNUCkKICAgICAgICAgIFR5cGU6IG5sODAyMTEgIEhX
IE1vZGUocyk6IDgwMi4xMWFjL2F4L24KICAgICAgICAgIEhhcmR3YXJlOiBlbWJlZGRlZCBbTWVk
aWFUZWsgTVQ3OTg2XQogICAgICAgICAgVFggcG93ZXIgb2Zmc2V0OiBub25lCiAgICAgICAgICBG
cmVxdWVuY3kgb2Zmc2V0OiBub25lCiAgICAgICAgICBTdXBwb3J0cyBWQVBzOiB5ZXMgIFBIWSBu
YW1lOiBwaHkxCgp3bGFuMS40ICAgRVNTSUQ6ICJCSC03MkMyMkQ1NEFCNkYiCiAgICAgICAgICBB
Y2Nlc3MgUG9pbnQ6IDg2OjBDOjQzOjI2OjYwOjAwCiAgICAgICAgICBNb2RlOiBNYXN0ZXIgIENo
YW5uZWw6IDM2ICg1LjE4MCBHSHopICBIVCBNb2RlOiBIRTgwCiAgICAgICAgICBDZW50ZXIgQ2hh
bm5lbCAxOiA0MiAyOiB1bmtub3duCiAgICAgICAgICBUeC1Qb3dlcjogNCBkQm0gIExpbmsgUXVh
bGl0eTogdW5rbm93bi83MAogICAgICAgICAgU2lnbmFsOiB1bmtub3duICBOb2lzZTogLTkyIGRC
bQogICAgICAgICAgQml0IFJhdGU6IHVua25vd24KICAgICAgICAgIEVuY3J5cHRpb246IFdQQTMg
U0FFIChDQ01QKQogICAgICAgICAgVHlwZTogbmw4MDIxMSAgSFcgTW9kZShzKTogODAyLjExYWMv
YXgvbgogICAgICAgICAgSGFyZHdhcmU6IGVtYmVkZGVkIFtNZWRpYVRlayBNVDc5ODZdCiAgICAg
ICAgICBUWCBwb3dlciBvZmZzZXQ6IG5vbmUKICAgICAgICAgIEZyZXF1ZW5jeSBvZmZzZXQ6IG5v
bmUKICAgICAgICAgIFN1cHBvcnRzIFZBUHM6IHllcyAgUEhZIG5hbWU6IHBoeTEKCnJvb3RAMDAw
MDAwMDAwMDp+IyAKcm9vdEAwMDAwMDAwMDAwOn4jIApyb290QDAwMDAwMDAwMDA6fiMgCnJvb3RA
MDAwMDAwMDAwMDp+IyAKcm9vdEAwMDAwMDAwMDAwOn4jIApyb290QDAwMDAwMDAwMDA6fiMgbG9n
cmVhZCAtZiB8IGdyZXAgLUUgJ2hvc3RhcGR8Y3NtbmdyJwoKU3VuIFNlcCAyOCAwNDowMzozMiAy
MDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogQ2ggPSAgMzYgaW50ZXJmZXJlbmNlLWZhY3Rv
ciA9IDAuMjI3OTQ3IApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3Ntbmdy
OiBwaHkxOiBDaCA9ICA0MCBpbnRlcmZlcmVuY2UtZmFjdG9yID0gMC4xNzkyMjEgClN1biBTZXAg
MjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IENoID0gIDQ0IGludGVy
ZmVyZW5jZS1mYWN0b3IgPSAwLjY0NjYxNyAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1v
bi5pbmZvIGNzbW5ncjogcGh5MTogQ2ggPSAgNDggaW50ZXJmZXJlbmNlLWZhY3RvciA9IDAuMTU2
MDk4IApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBD
aCA9IDE0OSBpbnRlcmZlcmVuY2UtZmFjdG9yID0gMC4wNjg1NzE0IApTdW4gU2VwIDI4IDA0OjAz
OjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBDaCA9IDE1MyBpbnRlcmZlcmVuY2Ut
ZmFjdG9yID0gMC4wMjg2Mzk2IApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8g
Y3NtbmdyOiBwaHkxOiBDaCA9IDE1NyBpbnRlcmZlcmVuY2UtZmFjdG9yID0gMC4wNDc3NDU0IApT
dW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBDaCA9IDE2
MSBpbnRlcmZlcmVuY2UtZmFjdG9yID0gMC4wNTcxNDI5IApTdW4gU2VwIDI4IDA0OjAzOjMyIDIw
MjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBDaCA9IDE2NSBpbnRlcmZlcmVuY2UtZmFjdG9y
ID0gMy45ODEwN2UtMTkgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21u
Z3I6IHBoeTE6IENoYW5uZWwgMTY1IGhhcyBsb3dlc3QgaW50ZXJmZXJlbmNlLWZhY3RvciAzLjk4
MTA3ZS0xOSAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5
MTogQ2ggPSAzNiBPQlNTID0gMjQgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5m
byBjc21uZ3I6IHBoeTE6IENoID0gNDAgT0JTUyA9IDUgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAy
NSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IENoID0gNDQgT0JTUyA9IDEgClN1biBTZXAgMjgg
MDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IENoID0gNDggT0JTUyA9IDEx
IApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBDaCA9
IDM2IE9CU1MgPSAyNCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5n
cjogcGh5MTogQ2ggPSA0NCBPQlNTID0gMSAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1v
bi5pbmZvIGNzbW5ncjogcGh5MTogQ2ggPSA0MCBPQlNTID0gNSAKU3VuIFNlcCAyOCAwNDowMzoz
MiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogQ2ggPSA0OCBPQlNTID0gMTEgClN1biBT
ZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5v
dC1jbGVhcmVkIGNoYW5uZWwgNTIgYncgMjAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVt
b24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgNTYgYncg
MjAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNr
aXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgNjAgYncgMjAgClN1biBTZXAgMjggMDQ6MDM6MzIg
MjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5u
ZWwgNjQgYncgMjAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6
IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgNTIgYncgNDAgClN1biBTZXAgMjgg
MDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVh
cmVkIGNoYW5uZWwgNjAgYncgNDAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5m
byBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgNTYgYncgNDAgClN1
biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZT
IG5vdC1jbGVhcmVkIGNoYW5uZWwgNjQgYncgNDAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBk
YWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgMTAw
IGJ3IDIwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkx
OiBza2lwIERGUyBub3QtY2xlYXJlZCBjaGFubmVsIDEwNCBidyAyMCAKU3VuIFNlcCAyOCAwNDow
MzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQg
Y2hhbm5lbCAxMDggYncgMjAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBj
c21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgMTEyIGJ3IDIwIApTdW4g
U2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBza2lwIERGUyBu
b3QtY2xlYXJlZCBjaGFubmVsIDExNiBidyAyMCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRh
ZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCAxMjAg
YncgMjAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6
IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgMTI0IGJ3IDIwIApTdW4gU2VwIDI4IDA0OjAz
OjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBza2lwIERGUyBub3QtY2xlYXJlZCBj
aGFubmVsIDEyOCBidyAyMCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNz
bW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCAxMzIgYncgMjAgClN1biBT
ZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5v
dC1jbGVhcmVkIGNoYW5uZWwgMTM2IGJ3IDIwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFl
bW9uLmluZm8gY3NtbmdyOiBwaHkxOiBza2lwIG5vbi1wcmVmZXJyZWQgY2hhbm5lbCAxNDAvMjAg
ClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAg
bm9uLXByZWZlcnJlZCBjaGFubmVsIDE0NC8yMCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRh
ZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCAxMDAg
YncgNDAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6
IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgMTA4IGJ3IDQwIApTdW4gU2VwIDI4IDA0OjAz
OjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBza2lwIERGUyBub3QtY2xlYXJlZCBj
aGFubmVsIDExNiBidyA0MCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNz
bW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCAxMjQgYncgNDAgClN1biBT
ZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5v
dC1jbGVhcmVkIGNoYW5uZWwgMTMyIGJ3IDQwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFl
bW9uLmluZm8gY3NtbmdyOiBwaHkxOiBza2lwIG5vbi1wcmVmZXJyZWQgY2hhbm5lbCAxNDAvNDAg
ClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAg
REZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgMTA0IGJ3IDQwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIw
MjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBza2lwIERGUyBub3QtY2xlYXJlZCBjaGFubmVs
IDExMiBidyA0MCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjog
cGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCAxMjAgYncgNDAgClN1biBTZXAgMjgg
MDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVh
cmVkIGNoYW5uZWwgMTI4IGJ3IDQwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmlu
Zm8gY3NtbmdyOiBwaHkxOiBza2lwIERGUyBub3QtY2xlYXJlZCBjaGFubmVsIDEzNiBidyA0MCAK
U3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBu
b24tcHJlZmVycmVkIGNoYW5uZWwgMTQ0LzQwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFl
bW9uLmluZm8gY3NtbmdyOiBwaHkxOiBDaCA9IDE0OSBPQlNTID0gMTQgClN1biBTZXAgMjggMDQ6
MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IENoID0gMTUzIE9CU1MgPSAwIApT
dW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBDaCA9IDE1
NyBPQlNTID0gMyAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjog
cGh5MTogQ2ggPSAxNjEgT0JTUyA9IDQgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24u
aW5mbyBjc21uZ3I6IHBoeTE6IENoID0gMTQ5IE9CU1MgPSAxNCAKU3VuIFNlcCAyOCAwNDowMzoz
MiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogQ2ggPSAxNTMgT0JTUyA9IDAgClN1biBT
ZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IENoID0gMTU3IE9C
U1MgPSAzIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkx
OiBDaCA9IDE2MSBPQlNTID0gNCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZv
IGNzbW5ncjogcGh5MTogQ2ggPSAxNjUgT0JTUyA9IDAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAy
NSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IENoID0gMTQ5IE9CU1MgPSAxNCAKU3VuIFNlcCAy
OCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogQ2ggPSAxNTcgT0JTUyA9
IDMgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IENo
ID0gMTY1IE9CU1MgPSAwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3Nt
bmdyOiBwaHkxOiBDaCA9IDE1MyBPQlNTID0gMCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRh
ZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogQ2ggPSAxNjEgT0JTUyA9IDQgClN1biBTZXAgMjggMDQ6
MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IENoID0gMzYgT0JTUyA9IDI0IApT
dW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBDaCA9IDQw
IE9CU1MgPSA1IApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBw
aHkxOiBDaCA9IDQ0IE9CU1MgPSAxIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmlu
Zm8gY3NtbmdyOiBwaHkxOiBDaCA9IDQ4IE9CU1MgPSAxMSAKU3VuIFNlcCAyOCAwNDowMzozMiAy
MDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5l
bCA1MiBidyA4MCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjog
cGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCA1NiBidyA4MCAKU3VuIFNlcCAyOCAw
NDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFy
ZWQgY2hhbm5lbCA2MCBidyA4MCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZv
IGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCA2NCBidyA4MCAKU3Vu
IFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMg
bm90LWNsZWFyZWQgY2hhbm5lbCAxMDAgYncgODAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBk
YWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgMTA0
IGJ3IDgwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkx
OiBza2lwIERGUyBub3QtY2xlYXJlZCBjaGFubmVsIDEwOCBidyA4MCAKU3VuIFNlcCAyOCAwNDow
MzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQg
Y2hhbm5lbCAxMTIgYncgODAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBj
c21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgMTE2IGJ3IDgwIApTdW4g
U2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBza2lwIERGUyBu
b3QtY2xlYXJlZCBjaGFubmVsIDEyMCBidyA4MCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRh
ZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCAxMjQg
YncgODAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6
IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgMTI4IGJ3IDgwIApTdW4gU2VwIDI4IDA0OjAz
OjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBza2lwIERGUyBub3QtY2xlYXJlZCBj
aGFubmVsIDEzMiBidyA4MCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNz
bW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCAxMzYgYncgODAgClN1biBT
ZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgbm9uLXBy
ZWZlcnJlZCBjaGFubmVsIDE0MC84MCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5p
bmZvIGNzbW5ncjogcGh5MTogc2tpcCBub24tcHJlZmVycmVkIGNoYW5uZWwgMTQ0LzgwIApTdW4g
U2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBDaCA9IDE0OSBP
QlNTID0gMTQgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBo
eTE6IENoID0gMTUzIE9CU1MgPSAwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmlu
Zm8gY3NtbmdyOiBwaHkxOiBDaCA9IDE1NyBPQlNTID0gMyAKU3VuIFNlcCAyOCAwNDowMzozMiAy
MDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogQ2ggPSAxNjEgT0JTUyA9IDQgClN1biBTZXAg
MjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1j
bGVhcmVkIGNoYW5uZWwgMzYgYncgMTYwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9u
LmluZm8gY3NtbmdyOiBwaHkxOiBza2lwIERGUyBub3QtY2xlYXJlZCBjaGFubmVsIDQwIGJ3IDE2
MCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tp
cCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCA0NCBidyAxNjAgClN1biBTZXAgMjggMDQ6MDM6MzIg
MjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5u
ZWwgNDggYncgMTYwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3Ntbmdy
OiBwaHkxOiBza2lwIERGUyBub3QtY2xlYXJlZCBjaGFubmVsIDUyIGJ3IDE2MCAKU3VuIFNlcCAy
OCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNs
ZWFyZWQgY2hhbm5lbCA1NiBidyAxNjAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24u
aW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNoYW5uZWwgNjAgYncgMTYw
IApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBza2lw
IERGUyBub3QtY2xlYXJlZCBjaGFubmVsIDY0IGJ3IDE2MCAKU3VuIFNlcCAyOCAwNDowMzozMiAy
MDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5l
bCAxMDAgYncgMTYwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3Ntbmdy
OiBwaHkxOiBza2lwIERGUyBub3QtY2xlYXJlZCBjaGFubmVsIDEwNCBidyAxNjAgClN1biBTZXAg
MjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1j
bGVhcmVkIGNoYW5uZWwgMTA4IGJ3IDE2MCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1v
bi5pbmZvIGNzbW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCAxMTIgYncg
MTYwIApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBz
a2lwIERGUyBub3QtY2xlYXJlZCBjaGFubmVsIDExNiBidyAxNjAgClN1biBTZXAgMjggMDQ6MDM6
MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IHNraXAgREZTIG5vdC1jbGVhcmVkIGNo
YW5uZWwgMTIwIGJ3IDE2MCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5pbmZvIGNz
bW5ncjogcGh5MTogc2tpcCBERlMgbm90LWNsZWFyZWQgY2hhbm5lbCAxMjQgYncgMTYwIApTdW4g
U2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBza2lwIERGUyBu
b3QtY2xlYXJlZCBjaGFubmVsIDEyOCBidyAxNjAgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBk
YWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAgMzYsIGJ3ID0gIDIwLCBTQ09SRSA9
IDguMTM2NzcgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBo
eTE6IGNoYW5uZWwgPSAgNDAsIGJ3ID0gIDIwLCBTQ09SRSA9IDIuMTA3NTMgClN1biBTZXAgMjgg
MDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAgNDQsIGJ3
ID0gIDIwLCBTQ09SRSA9IDEuMzg3OTcgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24u
aW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAgNDgsIGJ3ID0gIDIwLCBTQ09SRSA9IDQuMDkz
NjYgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNo
YW5uZWwgPSAxNDksIGJ3ID0gIDIwLCBTQ09SRSA9IDUuMDQxMTQgClN1biBTZXAgMjggMDQ6MDM6
MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAxNTMsIGJ3ID0gIDIw
LCBTQ09SRSA9IDEuMDE3MTggClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBj
c21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAxNTcsIGJ3ID0gIDIwLCBTQ09SRSA9IDEuMDI4NjUgClN1
biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwg
PSAxNjEsIGJ3ID0gIDIwLCBTQ09SRSA9IDIuMDM0MjkgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAy
NSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAxNjUsIGJ3ID0gIDIwLCBTQ09S
RSA9IDEgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6
IGNoYW5uZWwgPSAgMzYsIGJ3ID0gIDQwLCBTQ09SRSA9IDguMTIyMTUgClN1biBTZXAgMjggMDQ6
MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAgNDQsIGJ3ID0g
IDQwLCBTQ09SRSA9IDEuMjQwODEgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5m
byBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAgNDAsIGJ3ID0gIDQwLCBTQ09SRSA9IDIuMTIyMTUg
ClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5u
ZWwgPSAgNDgsIGJ3ID0gIDQwLCBTQ09SRSA9IDQuMjQwODEgClN1biBTZXAgMjggMDQ6MDM6MzIg
MjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAxNDksIGJ3ID0gIDQwLCBT
Q09SRSA9IDUuMDI5MTYgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21u
Z3I6IHBoeTE6IGNoYW5uZWwgPSAxNTcsIGJ3ID0gIDQwLCBTQ09SRSA9IDEuMDMxNDcgClN1biBT
ZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAx
NjUsIGJ3ID0gIDQwLCBTQ09SRSA9IDEgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24u
aW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAxNTMsIGJ3ID0gIDQwLCBTQ09SRSA9IDEuMDI5
MTYgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNo
YW5uZWwgPSAxNjEsIGJ3ID0gIDQwLCBTQ09SRSA9IDIuMDMxNDcgClN1biBTZXAgMjggMDQ6MDM6
MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAgMzYsIGJ3ID0gIDgw
LCBTQ09SRSA9IDguMTgxNDggClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBj
c21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAgNDAsIGJ3ID0gIDgwLCBTQ09SRSA9IDIuMTgxNDggClN1
biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwg
PSAgNDQsIGJ3ID0gIDgwLCBTQ09SRSA9IDEuMTgxNDggClN1biBTZXAgMjggMDQ6MDM6MzIgMjAy
NSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAgNDgsIGJ3ID0gIDgwLCBTQ09S
RSA9IDQuMTgxNDggClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6
IHBoeTE6IGNoYW5uZWwgPSAxNDksIGJ3ID0gIDgwLCBTQ09SRSA9IDUuMDMwMzEgClN1biBTZXAg
MjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAxNTMs
IGJ3ID0gIDgwLCBTQ09SRSA9IDEuMDMwMzEgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVt
b24uaW5mbyBjc21uZ3I6IHBoeTE6IGNoYW5uZWwgPSAxNTcsIGJ3ID0gIDgwLCBTQ09SRSA9IDEu
MDMwMzEgClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6
IGNoYW5uZWwgPSAxNjEsIGJ3ID0gIDgwLCBTQ09SRSA9IDIuMDMwMzEgClN1biBTZXAgMjggMDQ6
MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IEJFU1QgKCAyMCBNSHopOiBPcGNs
YXNzOiAxMjUgIGN0cmwtY2hhbm5lbCA9IDE2NSAgc2NvcmUgPSAxIApTdW4gU2VwIDI4IDA0OjAz
OjMyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkxOiBCRVNUICggNDAgTUh6KTogT3BjbGFz
czogMTI2ICBjdHJsLWNoYW5uZWwgPSAxNjUgIHNjb3JlID0gMSAKU3VuIFNlcCAyOCAwNDowMzoz
MiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MTogQkVTVCAoIDgwIE1Ieik6IE9wY2xhc3M6
IDEyOCAgY3RybC1jaGFubmVsID0gMTUzICBzY29yZSA9IDEuMDMwMzEgClN1biBTZXAgMjggMDQ6
MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTE6IFNldCBPUFRJTUFMIGNoYW5uZWwg
MTUzICggODAgTUh6KSBpbiBvcGNsYXNzIDEyOCAKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRh
ZW1vbi5pbmZvIGNzbW5ncjogd2lmaV9jaGFuX3N3aXRjaCh3bGFuMSk6IGZyZXEgPSA1NzY1LCBz
Y28gPSAwLCBlaHQgPSAwLCBoZSA9IDEsIHZodCA9IDEsIGh0ID0gMSAKU3VuIFNlcCAyOCAwNDow
MzozMiAyMDI1IGRhZW1vbi5pbmZvIGhvc3RhcGQ6IHdsYW4xOiBJRUVFIDgwMi4xMSBDSEFOX1NX
SVRDSCBFSFQgY29uZmlnIDB4MiBIRSBjb25maWcgMHgxIFZIVCBjb25maWcgMHgxClN1biBTZXAg
MjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBob3N0YXBkOiB3bGFuMS40OiBJRUVFIDgwMi4x
MSBDSEFOX1NXSVRDSCBFSFQgY29uZmlnIDB4MiBIRSBjb25maWcgMHgxIFZIVCBjb25maWcgMHgx
ClN1biBTZXAgMjggMDQ6MDM6MzIgMjAyNSBkYWVtb24uaW5mbyBob3N0YXBkOiB3bGFuMTogSUVF
RSA4MDIuMTEgZHJpdmVyIHN0YXJ0aW5nIGNoYW5uZWwgc3dpdGNoOiBpZmFjZS0+ZnJlcT01MTgw
LCBmcmVxPTU3NjUsIGh0PTEsIHZodF9jaD0weDEsIGhlX2NoPTB4MSwgZWh0X2NoPTB4Miwgb2Zm
c2V0PS0xLCB3aWR0aD0zICg4MCBNSHopLCBjZjE9NTc3NSwgY2YyPTAsIHB1bmN0dXJpbmdfYml0
bWFwPTB4MApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLm5vdGljZSBob3N0YXBkOiB3
bGFuMTogQ1RSTC1FVkVOVC1TVEFSVEVELUNIQU5ORUwtU1dJVENIIGZyZXE9NTc2NSBodF9lbmFi
bGVkPTEgY2hfb2Zmc2V0PS0xIGNoX3dpZHRoPTgwIE1IeiBjZjE9NTc3NSBjZjI9MCBpc19kZnMw
PTAgZGZzPTAgcHVuY3R1cmluZ19iaXRtYXA9MHgwMDAwClN1biBTZXAgMjggMDQ6MDM6MzIgMjAy
NSBkYWVtb24uaW5mbyBob3N0YXBkOiB3bGFuMS40OiBJRUVFIDgwMi4xMSBkcml2ZXIgc3RhcnRp
bmcgY2hhbm5lbCBzd2l0Y2g6IGlmYWNlLT5mcmVxPTU3NjUsIGZyZXE9NTc2NSwgaHQ9MSwgdmh0
X2NoPTB4MCwgaGVfY2g9MHgwLCBlaHRfY2g9MHgwLCBvZmZzZXQ9LTEsIHdpZHRoPTMgKDgwIE1I
eiksIGNmMT01Nzc1LCBjZjI9MCwgcHVuY3R1cmluZ19iaXRtYXA9MHgwClN1biBTZXAgMjggMDQ6
MDM6MzIgMjAyNSBkYWVtb24ubm90aWNlIGhvc3RhcGQ6IHdsYW4xLjQ6IENUUkwtRVZFTlQtU1RB
UlRFRC1DSEFOTkVMLVNXSVRDSCBmcmVxPTU3NjUgaHRfZW5hYmxlZD0xIGNoX29mZnNldD0tMSBj
aF93aWR0aD04MCBNSHogY2YxPTU3NzUgY2YyPTAgaXNfZGZzMD0wIGRmcz0wIHB1bmN0dXJpbmdf
Yml0bWFwPTB4MDAwMApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLmVyciBob3N0YXBk
OiBDYW5ub3Qgc2V0IGJlYWNvbnMgZHVyaW5nIENTQSBwZXJpb2QKU3VuIFNlcCAyOCAwNDowMzoz
MiAyMDI1IGRhZW1vbi5ub3RpY2UgaG9zdGFwZDogd2xhbjE6IGludGVyZmFjZSBzdGF0ZSBFTkFC
TEVELT5ERlMKU3VuIFNlcCAyOCAwNDowMzozMiAyMDI1IGRhZW1vbi5lcnIgaG9zdGFwZDogQ2Fu
bm90IHNldCBiZWFjb25zIGR1cmluZyBDU0EgcGVyaW9kClN1biBTZXAgMjggMDQ6MDM6MzIgMjAy
NSBkYWVtb24uZXJyIGhvc3RhcGQ6IENhbm5vdCBzZXQgYmVhY29ucyBkdXJpbmcgQ1NBIHBlcmlv
ZApTdW4gU2VwIDI4IDA0OjAzOjMyIDIwMjUgZGFlbW9uLm5vdGljZSBob3N0YXBkOiB3bGFuMTog
REZTLUNBQy1TVEFSVCBmcmVxPTU1MDAgY2hhbj0xMDAgY2hhbl9vZmZzZXQ9MCB3aWR0aD0zIHNl
ZzA9NTUzMCBzZWcxPTAgY2FjX3RpbWU9NjBzClN1biBTZXAgMjggMDQ6MDM6MzMgMjAyNSBkYWVt
b24uaW5mbyBob3N0YXBkOiB3bGFuMTogSUVFRSA4MDIuMTEgZHJpdmVyIGhhZCBjaGFubmVsIHN3
aXRjaDogaWZhY2UtPmZyZXE9NTc2NSwgZnJlcT01NzY1LCBodD0xLCB2aHRfY2g9MHgwLCBoZV9j
aD0weDAsIGVodF9jaD0weDAsIG9mZnNldD0tMSwgd2lkdGg9MyAoODAgTUh6KSwgY2YxPTU3NzUs
IGNmMj0wLCBwdW5jdHVyaW5nX2JpdG1hcD0weDAKU3VuIFNlcCAyOCAwNDowMzozMyAyMDI1IGRh
ZW1vbi5ub3RpY2UgaG9zdGFwZDogd2xhbjE6IENUUkwtRVZFTlQtQ0hBTk5FTC1TV0lUQ0ggZnJl
cT01NzY1IGh0X2VuYWJsZWQ9MSBjaF9vZmZzZXQ9LTEgY2hfd2lkdGg9ODAgTUh6IGNmMT01Nzc1
IGNmMj0wIGlzX2RmczA9MCBkZnM9MCBwdW5jdHVyaW5nX2JpdG1hcD0weDAwMDAKU3VuIFNlcCAy
OCAwNDowMzozMyAyMDI1IGRhZW1vbi5ub3RpY2UgaG9zdGFwZDogd2xhbjE6IEFQLUNTQS1GSU5J
U0hFRCBmcmVxPTU3NjUgZGZzPTAKU3VuIFNlcCAyOCAwNDowMzozMyAyMDI1IGRhZW1vbi53YXJu
IGhvc3RhcGQ6IC4uL3NyYy9hcC91YnVzLmNMMTA1QGhvc3RhcGRfdWJ1c19hcF9lbmFibGU6IFth
cmdjIDwgNF0gZmFpbGVkClN1biBTZXAgMjggMDQ6MDM6MzMgMjAyNSBkYWVtb24uaW5mbyBob3N0
YXBkOiB3bGFuMS40OiBJRUVFIDgwMi4xMSBkcml2ZXIgaGFkIGNoYW5uZWwgc3dpdGNoOiBpZmFj
ZS0+ZnJlcT01NzY1LCBmcmVxPTU3NjUsIGh0PTEsIHZodF9jaD0weDAsIGhlX2NoPTB4MCwgZWh0
X2NoPTB4MCwgb2Zmc2V0PS0xLCB3aWR0aD0zICg4MCBNSHopLCBjZjE9NTc3NSwgY2YyPTAsIHB1
bmN0dXJpbmdfYml0bWFwPTB4MApTdW4gU2VwIDI4IDA0OjAzOjMzIDIwMjUgZGFlbW9uLm5vdGlj
ZSBob3N0YXBkOiB3bGFuMS40OiBDVFJMLUVWRU5ULUNIQU5ORUwtU1dJVENIIGZyZXE9NTc2NSBo
dF9lbmFibGVkPTEgY2hfb2Zmc2V0PS0xIGNoX3dpZHRoPTgwIE1IeiBjZjE9NTc3NSBjZjI9MCBp
c19kZnMwPTAgZGZzPTAgcHVuY3R1cmluZ19iaXRtYXA9MHgwMDAwClN1biBTZXAgMjggMDQ6MDM6
MzMgMjAyNSBkYWVtb24ubm90aWNlIGhvc3RhcGQ6IHdsYW4xLjQ6IEFQLUNTQS1GSU5JU0hFRCBm
cmVxPTU3NjUgZGZzPTAKU3VuIFNlcCAyOCAwNDowMzozMyAyMDI1IGRhZW1vbi53YXJuIGhvc3Rh
cGQ6IC4uL3NyYy9hcC91YnVzLmNMMTA1QGhvc3RhcGRfdWJ1c19hcF9lbmFibGU6IFthcmdjIDwg
NF0gZmFpbGVkCgpTdW4gU2VwIDI4IDA0OjA0OjEyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBw
aHkwOiBDaCA9ICAgMSBpbnRlcmZlcmVuY2UtZmFjdG9yID0gMC42OTU0OTUgClN1biBTZXAgMjgg
MDQ6MDQ6MTIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IENoID0gICAyIGludGVyZmVy
ZW5jZS1mYWN0b3IgPSAwLjYxNDkwNyAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1IGRhZW1vbi5p
bmZvIGNzbW5ncjogcGh5MDogQ2ggPSAgIDMgaW50ZXJmZXJlbmNlLWZhY3RvciA9IDAuMjUyODc0
IApTdW4gU2VwIDI4IDA0OjA0OjEyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBDaCA9
ICAgNCBpbnRlcmZlcmVuY2UtZmFjdG9yID0gMC4yMzQwNDMgClN1biBTZXAgMjggMDQ6MDQ6MTIg
MjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IENoID0gICA1IGludGVyZmVyZW5jZS1mYWN0
b3IgPSAwLjM3MjU5NiAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5n
cjogcGh5MDogQ2ggPSAgIDYgaW50ZXJmZXJlbmNlLWZhY3RvciA9IDAuNzI2ODA0IApTdW4gU2Vw
IDI4IDA0OjA0OjEyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBDaCA9ICAgNyBpbnRl
cmZlcmVuY2UtZmFjdG9yID0gMC40MTQwMTMgClN1biBTZXAgMjggMDQ6MDQ6MTIgMjAyNSBkYWVt
b24uaW5mbyBjc21uZ3I6IHBoeTA6IENoID0gICA4IGludGVyZmVyZW5jZS1mYWN0b3IgPSAwLjU2
NzkwMSAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDog
Q2ggPSAgIDkgaW50ZXJmZXJlbmNlLWZhY3RvciA9IDAuODA1NzE0IApTdW4gU2VwIDI4IDA0OjA0
OjEyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBDaCA9ICAxMCBpbnRlcmZlcmVuY2Ut
ZmFjdG9yID0gMC4zNjQ3MDYgClN1biBTZXAgMjggMDQ6MDQ6MTIgMjAyNSBkYWVtb24uaW5mbyBj
c21uZ3I6IHBoeTA6IENoID0gIDExIGludGVyZmVyZW5jZS1mYWN0b3IgPSAwLjY1MjQwNiAKU3Vu
IFNlcCAyOCAwNDowNDoxMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogQ2ggPSAgMTIg
aW50ZXJmZXJlbmNlLWZhY3RvciA9IDAuMzk4ODc2IApTdW4gU2VwIDI4IDA0OjA0OjEyIDIwMjUg
ZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBDaCA9ICAxMyBpbnRlcmZlcmVuY2UtZmFjdG9yID0g
MC4xIApTdW4gU2VwIDI4IDA0OjA0OjEyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBD
aGFubmVsIDEzIGhhcyBsb3dlc3QgaW50ZXJmZXJlbmNlLWZhY3RvciAwLjEgClN1biBTZXAgMjgg
MDQ6MDQ6MTIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IENoID0gMSBPQlNTID0gNDkg
ClN1biBTZXAgMjggMDQ6MDQ6MTIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IHByZWZl
ciBjaGFubmVscyAxLDYgb3IgMTE7IHNraXAgMiAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1IGRh
ZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogcHJlZmVyIGNoYW5uZWxzIDEsNiBvciAxMTsgc2tpcCAz
IApTdW4gU2VwIDI4IDA0OjA0OjEyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBwcmVm
ZXIgY2hhbm5lbHMgMSw2IG9yIDExOyBza2lwIDQgClN1biBTZXAgMjggMDQ6MDQ6MTIgMjAyNSBk
YWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IHByZWZlciBjaGFubmVscyAxLDYgb3IgMTE7IHNraXAg
NSAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogQ2gg
PSA2IE9CU1MgPSAxMSAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5n
cjogcGh5MDogcHJlZmVyIGNoYW5uZWxzIDEsNiBvciAxMTsgc2tpcCA3IApTdW4gU2VwIDI4IDA0
OjA0OjEyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBwcmVmZXIgY2hhbm5lbHMgMSw2
IG9yIDExOyBza2lwIDggClN1biBTZXAgMjggMDQ6MDQ6MTIgMjAyNSBkYWVtb24uaW5mbyBjc21u
Z3I6IHBoeTA6IHByZWZlciBjaGFubmVscyAxLDYgb3IgMTE7IHNraXAgOSAKU3VuIFNlcCAyOCAw
NDowNDoxMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogcHJlZmVyIGNoYW5uZWxzIDEs
NiBvciAxMTsgc2tpcCAxMCAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1IGRhZW1vbi5pbmZvIGNz
bW5ncjogcGh5MDogQ2ggPSAxMSBPQlNTID0gNyAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1IGRh
ZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogcHJlZmVyIGNoYW5uZWxzIDEsNiBvciAxMTsgc2tpcCAx
MiAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogcHJl
ZmVyIGNoYW5uZWxzIDEsNiBvciAxMTsgc2tpcCAxMyAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1
IGRhZW1vbi5pbmZvIGNzbW5ncjogcGh5MDogc2tpcCA0ME1IeiBiYW5kd2lkdGggb3BjbGFzcyBp
biAyLjRHSHogClN1biBTZXAgMjggMDQ6MDQ6MTIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBo
eTA6IHNraXAgNDBNSHogYmFuZHdpZHRoIG9wY2xhc3MgaW4gMi40R0h6IApTdW4gU2VwIDI4IDA0
OjA0OjEyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBjaGFubmVsID0gICAxLCBidyA9
ICAyMCwgU0NPUkUgPSAxNS40MTczIApTdW4gU2VwIDI4IDA0OjA0OjEyIDIwMjUgZGFlbW9uLmlu
Zm8gY3NtbmdyOiBwaHkwOiBjaGFubmVsID0gICA2LCBidyA9ICAyMCwgU0NPUkUgPSA0LjQzNjA4
IApTdW4gU2VwIDI4IDA0OjA0OjEyIDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBjaGFu
bmVsID0gIDExLCBidyA9ICAyMCwgU0NPUkUgPSAzLjM5MTQ0IApTdW4gU2VwIDI4IDA0OjA0OjEy
IDIwMjUgZGFlbW9uLmluZm8gY3NtbmdyOiBwaHkwOiBCRVNUICggMjAgTUh6KTogT3BjbGFzczog
ODEgIGN0cmwtY2hhbm5lbCA9IDExICBzY29yZSA9IDMuMzkxNDQgClN1biBTZXAgMjggMDQ6MDQ6
MTIgMjAyNSBkYWVtb24uaW5mbyBjc21uZ3I6IHBoeTA6IFNldCBPUFRJTUFMIGNoYW5uZWwgMTEg
KCAyMCBNSHopIGluIG9wY2xhc3MgODEgClN1biBTZXAgMjggMDQ6MDQ6MTIgMjAyNSBkYWVtb24u
aW5mbyBjc21uZ3I6IHdpZmlfY2hhbl9zd2l0Y2god2xhbjAuNCk6IGZyZXEgPSAyNDYyLCBzY28g
PSAwLCBlaHQgPSAwLCBoZSA9IDEsIHZodCA9IDAsIGh0ID0gMSAKU3VuIFNlcCAyOCAwNDowNDox
MiAyMDI1IGRhZW1vbi5pbmZvIGhvc3RhcGQ6IHdsYW4wOiBJRUVFIDgwMi4xMSBDSEFOX1NXSVRD
SCBFSFQgY29uZmlnIDB4MiBIRSBjb25maWcgMHgxIFZIVCBjb25maWcgMHgyClN1biBTZXAgMjgg
MDQ6MDQ6MTIgMjAyNSBkYWVtb24uaW5mbyBob3N0YXBkOiB3bGFuMC40OiBJRUVFIDgwMi4xMSBD
SEFOX1NXSVRDSCBFSFQgY29uZmlnIDB4MiBIRSBjb25maWcgMHgxIFZIVCBjb25maWcgMHgyClN1
biBTZXAgMjggMDQ6MDQ6MTIgMjAyNSBkYWVtb24uaW5mbyBob3N0YXBkOiB3bGFuMDogSUVFRSA4
MDIuMTEgZHJpdmVyIHN0YXJ0aW5nIGNoYW5uZWwgc3dpdGNoOiBpZmFjZS0+ZnJlcT0yNDEyLCBm
cmVxPTI0NjIsIGh0PTEsIHZodF9jaD0weDIsIGhlX2NoPTB4MSwgZWh0X2NoPTB4Miwgb2Zmc2V0
PTAsIHdpZHRoPTEgKDIwIE1IeiksIGNmMT0yNDYyLCBjZjI9MCwgcHVuY3R1cmluZ19iaXRtYXA9
MHgwClN1biBTZXAgMjggMDQ6MDQ6MTIgMjAyNSBkYWVtb24ubm90aWNlIGhvc3RhcGQ6IHdsYW4w
OiBDVFJMLUVWRU5ULVNUQVJURUQtQ0hBTk5FTC1TV0lUQ0ggZnJlcT0yCjQ2MiBodF9lbmFibGVk
PTEgY2hfb2Zmc2V0PTAgY2hfd2lkdGg9MjAgTUh6IGNmMT0yNDYyIGNmMj0wIGlzX2RmczA9MCBk
ZnM9MCBwdW5jdHVyaW5nX2JpdG1hcD0weDAwMDAKU3VuIFNlcCAyOCAwNDowNDoxMiAyMDI1IGRh
ZW1vbi5pbmZvIGhvc3RhcGQ6IHdsYW4wLjQ6IElFRUUgODAyLjExIGRyaXZlciBzdGFydGluZyBj
aGFubmVsIHN3aXRjaDogaWZhY2UtPmZyZXE9MjQ2MiwgZnJlcT0yNDYyLCBodD0xLCB2aHRfY2g9
MHgwLCBoZV9jaD0weDAsIGVodF9jaD0weDAsIG9mZnNldD0wLCB3aWR0aD0xICgyMCBNSHopLCBj
ZjE9MjQ2MiwgY2YyPTAsIHB1bmN0dXJpbmdfYml0bWFwPTB4MApTdW4gU2VwIDI4IDA0OjA0OjEy
IDIwMjUgZGFlbW9uLm5vdGljZSBob3N0YXBkOiB3bGFuMC40OiBDVFJMLUVWRU5ULVNUQVJURUQt
Q0hBTk5FTC1TV0lUQ0ggZnJlcT0yNDYyIGh0X2VuYWJsZWQ9MSBjaF9vZmZzZXQ9MCBjaF93aWR0
aD0yMCBNSHogY2YxPTI0NjIgY2YyPTAgaXNfZGZzMD0wIGRmcz0wIHB1bmN0dXJpbmdfYml0bWFw
PTB4MDAwMApTdW4gU2VwIDI4IDA0OjA0OjEyIDIwMjUgZGFlbW9uLmVyciBob3N0YXBkOiBDYW5u
b3Qgc2V0IGJlYWNvbnMgZHVyaW5nIENTQSBwZXJpb2QKWyAgMjA5LjU5Nzk4OV0gLS0tLS0tLS0t
LS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tClsgIDIwOS42MDI2MThdIE5VTEwgZGVyZWZlcmVu
Y2UgY3Jhc2ggcHJvdGVjdGlvbiByZXNlcnZlZCBuZXdfY2hhbmRlZi0+Y2hhbiA9IDAwMDAwMDAw
MDAwMDAwMDAKWyAgMjA5LjYxMDk3OF0gV0FSTklORzogQ1BVOiAyIFBJRDogNTUxIGF0IGllZWU4
MDIxMV9pdGVyX2NoYW5fY29udGV4dHNfYXRvbWljKzB4MmQwLzB4ZjVjIFttYWM4MDIxMV0KWyAg
MjA5LjYxOTk1Ml0gTW9kdWxlcyBsaW5rZWQgaW46IHBwcG9lIG5mX2Zsb3dfdGFibGVfaW5ldCBt
dDc5MTVlKE8pIG10NzZfY29ubmFjX2xpYihPKSBtdDc2KE8pIG1hYzgwMjExKE8pIGwydHBfcHBw
IGlwdF9SRUpFQ1QgZWJ0YWJsZV9uYXQgZWJ0YWJsZV9maWx0ZXIgZWJ0YWJsZV9icm91dGUgY2Zn
ODAyMTEoTykgeHRfdGltZSB4dF90Y3B1ZHAgeHRfdGNwbXNzIHh0X3N0cmluZyB4dF9zdGF0aXN0
aWMgeHRfc3RhdGUgeHRfcmVjZW50IHh0X3F1b3RhIHh0X3BrdHR5cGUgeHRfCm93bmVyIHh0X25h
dCB4dF9tdWx0aXBvcnQgeHRfbWFyayB4dF9tYWMgeHRfbGltaXQgeHRfbGVuZ3RoIHh0X2lwcmFu
Z2UgeHRfaGwgeHRfaGVscGVyIHh0X2VjbiB4dF9kc2NwIHh0X2Nvbm50cmFjayB4dF9jb25ubWFy
ayB4dF9jb25ubGltaXQgeHRfY29ubmJ5dGVzIHh0X2NvbW1lbnQgeHRfY2dyb3VwIHh0X2JwZiB4
dF9hZGRydHlwZSB4dF9UQ1BNU1MgeHRfUkVESVJFQ1QgeHRfTkZRVUVVRSB4dF9ORkxPRyB4dF9N
QVNRVUVSQURFIHh0X0xPRyB4dF9JUE1BUksoTykgeHRfSEwgeAp0X0ZMT1dPRkZMT0FEIHh0X0RT
Q1AgeHRfQ1QgeHRfQ0xBU1NJRlkgdHNfZnNtIHRzX2JtIHNmcCBwcHRwIHBwcG94IHBwcF9tcHBl
IHBwcF9hc3luYyBuZnRfcmVqZWN0X2lwdjYgbmZ0X3JlamVjdF9pcHY0IG5mdF9yZWplY3RfaW5l
dCBuZnRfcmVqZWN0IG5mdF9yZWRpciBuZnRfcXVvdGEgbmZ0X251bWdlbiBuZnRfbmF0IG5mdF9t
YXNxIG5mdF9sb2cgbmZ0X2xpbWl0IG5mdF9oYXNoIG5mdF9mbG93X29mZmxvYWQgbmZ0X2N0IG5m
dF9jaGFpbl9uYXQgbmZuZXRsaW5rX3F1ZXVlIG4KZm5ldGxpbmtfbG9nIG5mX3RhYmxlcyBuZl9y
ZWplY3RfaXB2NCBuZl9uYXRfdGZ0cCBuZl9uYXRfc25tcF9iYXNpYyBuZl9uYXRfcHB0cCBuZl9u
YXRfaXJjIG5mX25hdF9oMzIzIG5mX25hdF9mdHAgbmZfbmF0X2FtYW5kYSBuZl9sb2dfc3lzbG9n
IG5mX2Zsb3dfdGFibGUgbmZfY29ubnRyYWNrX3RmdHAgbmZfY29ubnRyYWNrX3NubXAgbmZfY29u
bnRyYWNrX3NpcApbICAyMDkuNjIwMTMxXSAgbmZfY29ubnRyYWNrX3NhbmUgbmZfY29ubnRyYWNr
X3BwdHAgbmZfY29ubnRyYWNrX25ldGxpbmsgbmZfY29ubnRyYWNrX25ldGJpb3NfbnMgbmZfY29u
bnRyYWNrX2lyYyBuZl9jb25udHJhY2tfaDMyMyBuZl9jb25udHJhY2tfZnRwIG5mX2Nvbm50cmFj
a19icm9hZGNhc3QgdHNfa21wIG5mX2Nvbm50cmFja19hbWFuZGEgbmZfY29ubmNvdW50IG1kaW9f
aTJjIGxpYmNyYzMyYyBpcHRhYmxlX3JhdyBpcHRhYmxlX25hdCBpcHRhYmxlX21hbmdsZSBpcHRh
YmwKZV9maWx0ZXIgaXB0X0VDTiBpcF90YWJsZXMgaGlkX2dlbmVyaWMgZWJ0YWJsZXMgZWJ0X3Zs
YW4gZWJ0X3N0cCBlYnRfcmVkaXJlY3QgZWJ0X3BrdHR5cGUgZWJ0X21hcmtfbSBlYnRfbWFyayBl
YnRfbGltaXQgZWJ0X2Ftb25nIGVidF84MDJfMyBjb21wYXRfeHRhYmxlcyhPKSBjb21wYXQoTykg
YXNuMV9kZWNvZGVyIGNyeXB0b19zYWZleGNlbCBzY2hfdGJmIHNjaF9pbmdyZXNzIHNjaF9odGIg
c2NoX2hmc2MgZW1fdTMyIGNsc191MzIgY2xzX3JvdXRlIGNsc19tYXRjaGFsbCBjbHNfCmZ3IGNs
c19mbG93IGNsc19iYXNpYyBhY3Rfc2tiZWRpdCBhY3RfbWlycmVkIGFjdF9nYWN0IGNvbmZpZ3Mg
aGlkIGV2ZGV2IHB3bV9mYW4gaTJjX2dwaW8gaTJjX2FsZ29fYml0IHh0X3NldCBpcF9zZXRfbGlz
dF9zZXQgaXBfc2V0X2hhc2hfbmV0cG9ydG5ldCBpcF9zZXRfaGFzaF9uZXRwb3J0IGlwX3NldF9o
YXNoX25ldG5ldCBpcF9zZXRfaGFzaF9uZXRpZmFjZSBpcF9zZXRfaGFzaF9uZXQgaXBfc2V0X2hh
c2hfbWFjIGlwX3NldF9oYXNoX2lwcG9ydG5ldCBpcF9zZXRfaGFzaF9pcApwb3J0aXAgaXBfc2V0
X2hhc2hfaXBwb3J0IGlwX3NldF9oYXNoX2lwbWFyayBpcF9zZXRfaGFzaF9pcG1hYyBpcF9zZXRf
aGFzaF9pcCBpcF9zZXRfYml0bWFwX3BvcnQgaXBfc2V0X2JpdG1hcF9pcG1hYyBpcF9zZXRfYml0
bWFwX2lwIGlwX3NldCBuZm5ldGxpbmsgaXA2dGFibGVfbWFuZ2xlIGlwNnRhYmxlX2ZpbHRlciBp
cDZfdGFibGVzIGlwNnRfUkVKRUNUClsgIDIwOS43MTAyMzddICBuZl9yZWplY3RfaXB2NiBzd2Nv
bmZpZyBwcHBvYXRtIHBwcF9nZW5lcmljIHNsaGMgaXA2X2dyZSBpcF9ncmUgZ3JlIG5hdDQ2KE8p
IHNpdCBsMnRwX25ldGxpbmsgbDJ0cF9jb3JlIHVkcF90dW5uZWwgaXA2X3VkcF90dW5uZWwgaXA2
X3R1bm5lbCB0dW5uZWw2IHR1bm5lbDQgaXBfdHVubmVsIGVidF94dGlwNihPKSBlYnRfeHRpcChP
KSBlYnRfeHRhcnAoTykgZWJ0X3ZsYW50cmFuc2xhdGlvbihPKSB2ZXRoIGVidF9yYShPKSBlYnRf
cHBwb2VfZGlzYyhPKQogZWJ0X2RzY3AycGJpdChPKSBlYnRfZG5zKE8pIGVidF9kaGNwdjYoTykg
ZWJ0X2RoY3AoTykgYnIyNjg0IGF0bSBjcnlwdG9fdXNlciBhbGdpZl9za2NpcGhlciBhbGdpZl9y
bmcgYWxnaWZfaGFzaCBhbGdpZl9hZWFkIGFmX2FsZyBzaGE1MTJfYXJtNjQgc2hhMV9jZSBzaGEx
X2dlbmVyaWMgc2VxaXYgbWQ1IGdlbml2IGRlc19nZW5lcmljIGxpYmRlcyBjYmMgYXV0aGVuY2Vz
biBhdXRoZW5jIGFyYzQgZ3Bpb19rZXlzIGxlZHNfZ3BpbyB4aGNpX3BsYXRfaGNkIHhoY2lfcGNp
IHhoY2kKX210a19oY2QgeGhjaV9oY2QgYWhjaSBsaWJhaGNpIGlwdF9UUklHR0VSKE8pIGlwNnRf
VFJJR0dFUihPKSBuZl9uYXQgbmZfY29ubnRyYWNrIHhfdGFibGVzIG5mX2RlZnJhZ19pcHY2IG5m
X2RlZnJhZ19pcHY0IGRtX21pcnJvciBkbV9yZWdpb25faGFzaCBkbV9sb2cgZG1fY3J5cHQgZG1f
bW9kIGRheCBidXR0b25faG90cGx1ZyhPKSBpbnB1dF9jb3JlIHVzYmNvcmUgdXNiX2NvbW1vbiBh
cXVhbnRpYSB0cG0gZW5jcnlwdGVkX2tleXMgdHJ1c3RlZCBbbGFzdCB1bmxvYWRlZDogbmZfCm5h
dF9zaXBdClsgIDIwOS44NzI3MTRdIENQVTogMiBQSUQ6IDU1MSBDb21tOiBrd29ya2VyL3U4OjUg
VGFpbnRlZDogRyAgICAgICAgICAgTyAgICAgICA2LjYuNzMgIzAKWyAgMjA5Ljg4MDUyM10gSGFy
ZHdhcmUgbmFtZTogQmFuYW5hcGkgQlBJLVIzIChEVCkKWyAgMjA5Ljg4NTAzN10gV29ya3F1ZXVl
OiBldmVudHNfdW5ib3VuZCB3aXBoeV9kZWxheWVkX3dvcmtfcGVuZGluZyBbY2ZnODAyMTFdClsg
IDIwOS44OTIwMDNdIHBzdGF0ZTogODA0MDAwMDUgKE56Y3YgZGFpZiArUEFOIC1VQU8gLVRDTyAt
RElUIC1TU0JTIEJUWVBFPS0tKQpbICAyMDkuODk4OTQ0XSBwYyA6IGllZWU4MDIxMV9pdGVyX2No
YW5fY29udGV4dHNfYXRvbWljKzB4MmQwLzB4ZjVjIFttYWM4MDIxMV0KWyAgMjA5LjkwNTkxOF0g
bHIgOiBpZWVlODAyMTFfaXRlcl9jaGFuX2NvbnRleHRzX2F0b21pYysweDJkMC8weGY1YyBbbWFj
ODAyMTFdClsgIDIwOS45MTI4NzZdIHNwIDogZmZmZmZmYzA4MjI0M2MwMApbICAyMDkuOTE2MTc0
XSB4Mjk6IGZmZmZmZmMwODIyNDNjMDAgeDI4OiBmZmZmZmY4MDA2ZjUwZjA4IHgyNzogZmZmZmZm
ODAwNmY1MDhjMApbICAyMDkuOTIzMjkxXSB4MjY6IDAwMDAwMDAwMDAwMDAwMDEgeDI1OiAwMDAw
MDAwMDAwMDAwMDAxIHgyNDogZmZmZmZmODAwZDc0OWFhMApbICAyMDkuOTMwNDA3XSB4MjM6IGZm
ZmZmZjgwMDAxOWMwMDAgeDIyOiBmZmZmZmY4MDAxYThjOTAwIHgyMTogZmZmZmZmODAwMDE5YzY3
OApbICAyMDkuOTM3NTIzXSB4MjA6IGZmZmZmZjgwMDFhOGRiNzggeDE5OiAwMDAwMDAwMDAwMDAw
MDAwIHgxODogMDAwMDAwMDAwMDAwMDE2YwpbICAyMDkuOTQ0NjM4XSB4MTc6IDMwMjAzZDIwNmU2
MTY4NjMgeDE2OiAzZTJkNjY2NTY0NmU2MTY4IHgxNTogZmZmZmZmYzA4MGJkZjI5MApbICAyMDku
OTUxNzU0XSB4MTQ6IDAwMDAwMDAwMDAwMDA0NDQgeDEzOiAwMDAwMDAwMDAwMDAwMTZjIHgxMjog
MDAwMDAwMDBmZmZmZmZlYQpbICAyMDkuOTU4ODcwXSB4MTE6IDAwMDAwMDAwZmZmZmVmZmYgeDEw
OiBmZmZmZmZjMDgwYzM3MjkwIHg5IDogZmZmZmZmYzA4MGJkZjIzOApbICAyMDkuOTY1OTg2XSB4
OCA6IDAwMDAwMDAwMDAwMTdmZTggeDcgOiBjMDAwMDAwMGZmZmZlZmZmIHg2IDogMDAwMDAwMDAw
MDAwMDAwMQpbICAyMDkuOTczMTAxXSB4NSA6IGZmZmZmZjgwN2ZiYTY3OTAgeDQgOiAwMDAwMDAw
MDAwMDAwMDAwIHgzIDogMDAwMDAwMDAwMDAwMDAyNwpbICAyMDkuOTgwMjE3XSB4MiA6IDAwMDAw
MDAwMDAwMDAwMjcgeDEgOiAwMDAwMDAwMDAwMDAwMDIzIHgwIDogMDAwMDAwMDAwMDAwMDA0Zgpb
ICAyMDkuOTg3MzMyXSBDYWxsIHRyYWNlOgpbICAyMDkuOTg5NzY0XSAgaWVlZTgwMjExX2l0ZXJf
Y2hhbl9jb250ZXh0c19hdG9taWMrMHgyZDAvMHhmNWMgW21hYzgwMjExXQpbICAyMDkuOTk2Mzgx
XSAgaWVlZTgwMjExX2xpbmtfdW5yZXNlcnZlX2NoYW5jdHgrMHg0MjQvMHhhYWMgW21hYzgwMjEx
XQpbICAyMTAuMDAyNzM0XSAgaWVlZTgwMjExX2xpbmtfdXNlX3Jlc2VydmVkX2NvbnRleHQrMHhh
Yy8weGY0IFttYWM4MDIxMV0KWyAgMjEwLjAwOTE3Ml0gIGllZWU4MDIxMV9uYW5fZnVuY190ZXJt
aW5hdGVkKzB4M2UxMC8weDRkMTAgW21hYzgwMjExXQpbICAyMTAuMDE1NDM3XSAgaWVlZTgwMjEx
X2NzYV9maW5hbGl6ZV93b3JrKzB4MmMvMHgzNCBbbWFjODAyMTFdClsgIDIxMC4wMjExODJdICB3
aXBoeV9kZWxheWVkX3dvcmtfcGVuZGluZysweDJhNC8weDNjOCBbY2ZnODAyMTFdClsgIDIxMC4w
MjcwMTFdICBwcm9jZXNzX29uZV93b3JrKzB4MTc4LzB4MmYwClsgIDIxMC4wMzEwMTBdICB3b3Jr
ZXJfdGhyZWFkKzB4MmU0LzB4NGNjClsgIDIxMC4wMzQ3NDVdICBrdGhyZWFkKzB4ZDgvMHhkYwpb
ICAyMTAuMDM3Nzg2XSAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjAKWyAgMjEwLjA0MTM0OF0gLS0t
WyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tClsgIDIxMC4wNDYwMTldIC0tLS0tLS0t
LS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQpbICAyMTAuMDUwNjI2XSBOVUxMIGRlcmVmZXJl
bmNlIGNyYXNoIHByb3RlY3Rpb24gcmVzZXJ2ZWQgbmV3X2NoYW5kZWYtPmNoYW4gPSAwMDAwMDAw
MDAwMDAwMDAwClsgIDIxMC4wNTkwMjRdIFdBUk5JTkc6IENQVTogMiBQSUQ6IDU1MSBhdCBpZWVl
ODAyMTFfaXRlcl9jaGFuX2NvbnRleHRzX2F0b21pYysweDJkMC8weGY1YyBbbWFjODAyMTFdClsg
IDIxMC4wNjgwMDddIE1vZHVsZXMgbGlua2VkIGluOiBwcHBvZSBuZl9mbG93X3RhYmxlX2luZXQg
bXQ3OTE1ZShPKSBtdDc2X2Nvbm5hY19saWIoTykgbXQ3NihPKSBtYWM4MDIxMShPKSBsMnRwX3Bw
cCBpcHRfUkVKRUNUIGVidGFibGVfbmF0IGVidGFibGVfZmlsdGVyIGVidGFibGVfYnJvdXRlIGNm
ZzgwMjExKE8pIHh0X3RpbWUgeHRfdGNwdWRwIHh0X3RjcG1zcyB4dF9zdHJpbmcgeHRfc3RhdGlz
dGljIHh0X3N0YXRlIHh0X3JlY2VudCB4dF9xdW90YSB4dF9wa3R0eXBlIHh0Xwpvd25lciB4dF9u
YXQgeHRfbXVsdGlwb3J0IHh0X21hcmsgeHRfbWFjIHh0X2xpbWl0IHh0X2xlbmd0aCB4dF9pcHJh
bmdlIHh0X2hsIHh0X2hlbHBlciB4dF9lY24geHRfZHNjcCB4dF9jb25udHJhY2sgeHRfY29ubm1h
cmsgeHRfY29ubmxpbWl0IHh0X2Nvbm5ieXRlcyB4dF9jb21tZW50IHh0X2Nncm91cCB4dF9icGYg
eHRfYWRkcnR5cGUgeHRfVENQTVNTIHh0X1JFRElSRUNUIHh0X05GUVVFVUUgeHRfTkZMT0cgeHRf
TUFTUVVFUkFERSB4dF9MT0cgeHRfSVBNQVJLKE8pIHh0X0hMIHgKdF9GTE9XT0ZGTE9BRCB4dF9E
U0NQIHh0X0NUIHh0X0NMQVNTSUZZIHRzX2ZzbSB0c19ibSBzZnAgcHB0cCBwcHBveCBwcHBfbXBw
ZSBwcHBfYXN5bmMgbmZ0X3JlamVjdF9pcHY2IG5mdF9yZWplY3RfaXB2NCBuZnRfcmVqZWN0X2lu
ZXQgbmZ0X3JlamVjdCBuZnRfcmVkaXIgbmZ0X3F1b3RhIG5mdF9udW1nZW4gbmZ0X25hdCBuZnRf
bWFzcSBuZnRfbG9nIG5mdF9saW1pdCBuZnRfaGFzaCBuZnRfZmxvd19vZmZsb2FkIG5mdF9jdCBu
ZnRfY2hhaW5fbmF0IG5mbmV0bGlua19xdWV1ZSBuCmZuZXRsaW5rX2xvZyBuZl90YWJsZXMgbmZf
cmVqZWN0X2lwdjQgbmZfbmF0X3RmdHAgbmZfbmF0X3NubXBfYmFzaWMgbmZfbmF0X3BwdHAgbmZf
bmF0X2lyYyBuZl9uYXRfaDMyMyBuZl9uYXRfZnRwIG5mX25hdF9hbWFuZGEgbmZfbG9nX3N5c2xv
ZyBuZl9mbG93X3RhYmxlIG5mX2Nvbm50cmFja190ZnRwIG5mX2Nvbm50cmFja19zbm1wIG5mX2Nv
bm50cmFja19zaXAKWyAgMjEwLjA2ODE3NF0gIG5mX2Nvbm50cmFja19zYW5lIG5mX2Nvbm50cmFj
a19wcHRwIG5mX2Nvbm50cmFja19uZXRsaW5rIG5mX2Nvbm50cmFja19uZXRiaW9zX25zIG5mX2Nv
bm50cmFja19pcmMgbmZfY29ubnRyYWNrX2gzMjMgbmZfY29ubnRyYWNrX2Z0cCBuZl9jb25udHJh
Y2tfYnJvYWRjYXN0IHRzX2ttcCBuZl9jb25udHJhY2tfYW1hbmRhIG5mX2Nvbm5jb3VudCBtZGlv
X2kyYyBsaWJjcmMzMmMgaXB0YWJsZV9yYXcgaXB0YWJsZV9uYXQgaXB0YWJsZV9tYW5nbGUgaXB0
YWJsCmVfZmlsdGVyIGlwdF9FQ04gaXBfdGFibGVzIGhpZF9nZW5lcmljIGVidGFibGVzIGVidF92
bGFuIGVidF9zdHAgZWJ0X3JlZGlyZWN0IGVidF9wa3R0eXBlIGVidF9tYXJrX20gZWJ0X21hcmsg
ZWJ0X2xpbWl0IGVidF9hbW9uZyBlYnRfODAyXzMgY29tcGF0X3h0YWJsZXMoTykgY29tcGF0KE8p
IGFzbjFfZGVjb2RlciBjcnlwdG9fc2FmZXhjZWwgc2NoX3RiZiBzY2hfaW5ncmVzcyBzY2hfaHRi
IHNjaF9oZnNjIGVtX3UzMiBjbHNfdTMyIGNsc19yb3V0ZSBjbHNfbWF0Y2hhbGwgY2xzXwpmdyBj
bHNfZmxvdyBjbHNfYmFzaWMgYWN0X3NrYmVkaXQgYWN0X21pcnJlZCBhY3RfZ2FjdCBjb25maWdz
IGhpZCBldmRldiBwd21fZmFuIGkyY19ncGlvIGkyY19hbGdvX2JpdCB4dF9zZXQgaXBfc2V0X2xp
c3Rfc2V0IGlwX3NldF9oYXNoX25ldHBvcnRuZXQgaXBfc2V0X2hhc2hfbmV0cG9ydCBpcF9zZXRf
aGFzaF9uZXRuZXQgaXBfc2V0X2hhc2hfbmV0aWZhY2UgaXBfc2V0X2hhc2hfbmV0IGlwX3NldF9o
YXNoX21hYyBpcF9zZXRfaGFzaF9pcHBvcnRuZXQgaXBfc2V0X2hhc2hfaXAKcG9ydGlwIGlwX3Nl
dF9oYXNoX2lwcG9ydCBpcF9zZXRfaGFzaF9pcG1hcmsgaXBfc2V0X2hhc2hfaXBtYWMgaXBfc2V0
X2hhc2hfaXAgaXBfc2V0X2JpdG1hcF9wb3J0IGlwX3NldF9iaXRtYXBfaXBtYWMgaXBfc2V0X2Jp
dG1hcF9pcCBpcF9zZXQgbmZuZXRsaW5rIGlwNnRhYmxlX21hbmdsZSBpcDZ0YWJsZV9maWx0ZXIg
aXA2X3RhYmxlcyBpcDZ0X1JFSkVDVApbICAyMTAuMTU4MjczXSAgbmZfcmVqZWN0X2lwdjYgc3dj
b25maWcgcHBwb2F0bSBwcHBfZ2VuZXJpYyBzbGhjIGlwNl9ncmUgaXBfZ3JlIGdyZSBuYXQ0NihP
KSBzaXQgbDJ0cF9uZXRsaW5rIGwydHBfY29yZSB1ZHBfdHVubmVsIGlwNl91ZHBfdHVubmVsIGlw
Nl90dW5uZWwgdHVubmVsNiB0dW5uZWw0IGlwX3R1bm5lbCBlYnRfeHRpcDYoTykgZWJ0X3h0aXAo
TykgZWJ0X3h0YXJwKE8pIGVidF92bGFudHJhbnNsYXRpb24oTykgdmV0aCBlYnRfcmEoTykgZWJ0
X3BwcG9lX2Rpc2MoTykKIGVidF9kc2NwMnBiaXQoTykgZWJ0X2RucyhPKSBlYnRfZGhjcHY2KE8p
IGVidF9kaGNwKE8pIGJyMjY4NCBhdG0gY3J5cHRvX3VzZXIgYWxnaWZfc2tjaXBoZXIgYWxnaWZf
cm5nIGFsZ2lmX2hhc2ggYWxnaWZfYWVhZCBhZl9hbGcgc2hhNTEyX2FybTY0IHNoYTFfY2Ugc2hh
MV9nZW5lcmljIHNlcWl2IG1kNSBnZW5pdiBkZXNfZ2VuZXJpYyBsaWJkZXMgY2JjIGF1dGhlbmNl
c24gYXV0aGVuYyBhcmM0IGdwaW9fa2V5cyBsZWRzX2dwaW8geGhjaV9wbGF0X2hjZCB4aGNpX3Bj
aSB4aGNpCl9tdGtfaGNkIHhoY2lfaGNkIGFoY2kgbGliYWhjaSBpcHRfVFJJR0dFUihPKSBpcDZ0
X1RSSUdHRVIoTykgbmZfbmF0IG5mX2Nvbm50cmFjayB4X3RhYmxlcyBuZl9kZWZyYWdfaXB2NiBu
Zl9kZWZyYWdfaXB2NCBkbV9taXJyb3IgZG1fcmVnaW9uX2hhc2ggZG1fbG9nIGRtX2NyeXB0IGRt
X21vZCBkYXggYnV0dG9uX2hvdHBsdWcoTykgaW5wdXRfY29yZSB1c2Jjb3JlIHVzYl9jb21tb24g
YXF1YW50aWEgdHBtIGVuY3J5cHRlZF9rZXlzIHRydXN0ZWQgW2xhc3QgdW5sb2FkZWQ6IG5mXwpu
YXRfc2lwXQpbICAyMTAuMzIwNzM2XSBDUFU6IDIgUElEOiA1NTEgQ29tbToga3dvcmtlci91ODo1
IFRhaW50ZWQ6IEcgICAgICAgIFcgIE8gICAgICAgNi42LjczICMwClsgIDIxMC4zMjg1NDZdIEhh
cmR3YXJlIG5hbWU6IEJhbmFuYXBpIEJQSS1SMyAoRFQpClsgIDIxMC4zMzMwNTldIFdvcmtxdWV1
ZTogZXZlbnRzX3VuYm91bmQgd2lwaHlfZGVsYXllZF93b3JrX3BlbmRpbmcgW2NmZzgwMjExXQpb
ICAyMTAuMzQwMDI3XSBwc3RhdGU6IDYwNDAwMDA1IChuWkN2IGRhaWYgK1BBTiAtVUFPIC1UQ08g
LURJVCAtU1NCUyBCVFlQRT0tLSkKWyAgMjEwLjM0Njk2OF0gcGMgOiBpZWVlODAyMTFfaXRlcl9j
aGFuX2NvbnRleHRzX2F0b21pYysweDJkMC8weGY1YyBbbWFjODAyMTFdClsgIDIxMC4zNTM5MzZd
IGxyIDogaWVlZTgwMjExX2l0ZXJfY2hhbl9jb250ZXh0c19hdG9taWMrMHgyZDAvMHhmNWMgW21h
YzgwMjExXQpbICAyMTAuMzYwODk0XSBzcCA6IGZmZmZmZmMwODIyNDNjMDAKWyAgMjEwLjM2NDE5
Ml0geDI5OiBmZmZmZmZjMDgyMjQzYzAwIHgyODogZmZmZmZmODAwNmY1MGYwOCB4Mjc6IGZmZmZm
ZjgwMDZmNTA4YzAKWyAgMjEwLjM3MTMwOV0geDI2OiAwMDAwMDAwMDAwMDAwMDAxIHgyNTogMDAw
MDAwMDAwMDAwMDAwMSB4MjQ6IGZmZmZmZjgwMGQ3NDlhYTAKWyAgMjEwLjM3ODQyNV0geDIzOiBm
ZmZmZmY4MDAwMTljMDAwIHgyMjogZmZmZmZmODAwMWE4YzkwMCB4MjE6IGZmZmZmZjgwMDAxOWM2
NzgKWyAgMjEwLjM4NTU0MF0geDIwOiBmZmZmZmY4MDAxYThkYjc4IHgxOTogMDAwMDAwMDAwMDAw
MDAwMCB4MTg6IDAwMDAwMDAwMDAwMDAxOGYKWyAgMjEwLjM5MjY1Nl0geDE3OiAzMDIwM2QyMDZl
NjE2ODYzIHgxNjogM2UyZDY2NjU2NDZlNjE2OCB4MTU6IGZmZmZmZmMwODBiZGYyOTAKWyAgMjEw
LjM5OTc3Ml0geDE0OiAwMDAwMDAwMDAwMDAwNGFkIHgxMzogMDAwMDAwMDAwMDAwMDE4ZiB4MTI6
IDAwMDAwMDAwZmZmZmZmZWEKWyAgMjEwLjQwNjg4N10geDExOiAwMDAwMDAwMGZmZmZlZmZmIHgx
MDogZmZmZmZmYzA4MGMzNzI5MCB4OSA6IGZmZmZmZmMwODBiZGYyMzgKWyAgMjEwLjQxNDAwM10g
eDggOiAwMDAwMDAwMDAwMDE3ZmU4IHg3IDogYzAwMDAwMDBmZmZmZWZmZiB4NiA6IDAwMDAwMDAw
MDAwMDAwMDEKWyAgMjEwLjQyMTExOV0geDUgOiAwMDAwMDAwMDAwMDAwMDAwIHg0IDogMDAwMDAw
MDAwMDAwMDAwMCB4MyA6IDAwMDAwMDAwMDAwMDAwMDAKWyAgMjEwLjQyODIzNF0geDIgOiBmZmZm
ZmY4MDdmYmE5NGQwIHgxIDogZmZmZmZmYmZmZWZmNjAwMCB4MCA6IDAwMDAwMDAwMDAwMDAwNGYK
WyAgMjEwLjQzNTM1MF0gQ2FsbCB0cmFjZToKWyAgMjEwLjQzNzc4Ml0gIGllZWU4MDIxMV9pdGVy
X2NoYW5fY29udGV4dHNfYXRvbWljKzB4MmQwLzB4ZjVjIFttYWM4MDIxMV0KWyAgMjEwLjQ0NDM5
N10gIGllZWU4MDIxMV9saW5rX3VucmVzZXJ2ZV9jaGFuY3R4KzB4NDI0LzB4YWFjIFttYWM4MDIx
MV0KWyAgMjEwLjQ1MDc0OV0gIGllZWU4MDIxMV9saW5rX3VzZV9yZXNlcnZlZF9jb250ZXh0KzB4
YWMvMHhmNCBbbWFjODAyMTFdClsgIDIxMC40NTcxODddICBpZWVlODAyMTFfbmFuX2Z1bmNfdGVy
bWluYXRlZCsweDNlMTAvMHg0ZDEwIFttYWM4MDIxMV0KWyAgMjEwLjQ2MzQ1Ml0gIGllZWU4MDIx
MV9jc2FfZmluYWxpemVfd29yaysweDJjLzB4MzQgW21hYzgwMjExXQpbICAyMTAuNDY5MTk2XSAg
d2lwaHlfZGVsYXllZF93b3JrX3BlbmRpbmcrMHgyYTQvMHgzYzggW2NmZzgwMjExXQpbICAyMTAu
NDc1MDIzXSAgcHJvY2Vzc19vbmVfd29yaysweDE3OC8weDJmMApbICAyMTAuNDc5MDIyXSAgd29y
a2VyX3RocmVhZCsweDJlNC8weDRjYwpbICAyMTAuNDgyNzU3XSAga3RocmVhZCsweGQ4LzB4ZGMK
WyAgMjEwLjQ4NTc5OF0gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwClsgIDIxMC40ODkzNjBdIC0t
LVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQpTdW4gU2VwIDI4IDA0OjA0OjEzIDIw
MjUgZGFlbW9uLmVyciBob3N0YXBkOiBDYW5ub3Qgc2V0IGJlYWNvbnMgZHVyaW5nIENTQSBwZXJp
b2QKU3VuIFNlcCAyOCAwNDowNDoxMyAyMDI1IGRhZW1vbi5pbmZvIGhvc3RhcGQ6IHdsYW4wOiBJ
RUVFIDgwMi4xMSBkcml2ZXIgaGFkIGNoYW5uZWwgc3dpdGNoOiBpZmFjZS0+ZnJlcT0yNDYyLCBm
cmVxPTI0NjIsIGh0PTEsIHZodF9jaD0weDAsIGhlX2NoPTB4MCwgZWh0X2NoPTB4MCwgb2Zmc2V0
PTAsIHdpZHRoPTEgKDIwIE1IeiksIGNmMT0yNDYyLCBjZjI9MCwgcHVuY3R1cmluZ19iaXRtYXA9
MHgwClN1biBTZXAgMjggMDQ6MDQ6MTMgMjAyNSBkYWVtb24ubm90aWNlIGhvc3RhcGQ6IHdsYW4w
OiBDVFJMLUVWRU5ULUNIQU5ORUwtU1dJVENIIGZyZXE9MjQ2MiBodF9lbmFibGVkPTEgY2hfb2Zm
c2V0PTAgY2hfd2lkdGg9MjAgTUh6IGNmMT0yNDYyIGNmMj0wIGlzX2RmczA9MCBkZnM9MCBwdW5j
dHVyaW5nX2JpdG1hcD0weDAwMDAKU3VuIFNlcCAyOCAwNDowNDoxMyAyMDI1IGRhZW1vbi5ub3Rp
Y2UgaG9zdGFwZDogd2xhbjA6IEFQLUNTQS1GSU5JU0hFRCBmcmVxPTI0NjIgZGZzPTAKU3VuIFNl
cCAyOCAwNDowNDoxMyAyMDI1IGRhZW1vbi53YXJuIGhvc3RhcGQ6IC4uL3NyYy9hcC91YnVzLmNM
MTA1QGhvc3RhcGRfdWJ1c19hcF9lbmFibGU6IFthcmdjIDwgNF0gZmFpbGVkClN1biBTZXAgMjgg
MDQ6MDQ6MTMgMjAyNSBkYWVtb24uaW5mbyBob3N0YXBkOiB3bGFuMC40OiBJRUVFIDgwMi4xMSBk
cml2ZXIgaGFkIGNoYW5uZWwgc3dpdGNoOiBpZmFjZS0+ZnJlcT0yNDYyLCBmcmVxPTI0NjIsIGh0
PTEsIHZodF9jaD0weDAsIGhlX2NoPTB4MCwgZWh0X2NoPTB4MCwgb2Zmc2V0PTAsIHdpZHRoPTEg
KDIwIE1IeiksIGNmMT0yNDYyLCBjZjI9MCwgcHVuY3R1cmluZ19iaXRtYXA9MHgwClN1biBTZXAg
MjggMDQ6MDQ6MTMgMjAyNSBkYWVtb24ubm90aWNlIGhvc3RhcGQ6IHdsYW4wLjQ6IENUUkwtRVZF
TlQtQ0hBTk5FTC1TV0lUQ0ggZnJlcT0yNDYyIGh0X2VuYWJsZWQ9MSBjaF9vZmZzZXQ9MCBjaF93
aWR0aD0yMCBNSHogY2YxPTI0NjIgY2YyPTAgaXNfZGZzMD0wIGRmcz0wIHB1bmN0dXJpbmdfYml0
bWFwPTB4MDAwMApTdW4gU2VwIDI4IDA0OjA0OjEzIDIwMjUgZGFlbW9uLm5vdGljZSBob3N0YXBk
OiB3bGFuMC40OiBBUC1DU0EtRklOSVNIRUQgZnJlcT0yNDYyIGRmcz0wClN1biBTZXAgMjggMDQ6
MDQ6MTMgMjAyNSBkYWVtb24ud2FybiBob3N0YXBkOiAuLi9zcmMvYXAvdWJ1cy5jTDEwNUBob3N0
YXBkX3VidXNfYXBfZW5hYmxlOiBbYXJnYyA8IDRdIGZhaWxlZAoKCgpTdW4gU2VwIDI4IDA0OjA0
OjM2IDIwMjUgZGFlbW9uLm5vdGljZSBob3N0YXBkOiB3bGFuMTogREZTLUNBQy1DT01QTEVURUQg
c3VjY2Vzcz0xIGZyZXE9NTUwMCBodF9lbmFibGVkPTAgY2hhbl9vZmZzZXQ9MCBjaGFuX3dpZHRo
PTMgY2YxPTU1MzAgY2YyPTAgcmFkYXJfZGV0ZWN0ZWQ9MApTdW4gU2VwIDI4IDA0OjA0OjM2IDIw
MjUgZGFlbW9uLmVyciBob3N0YXBkOiBob3N0YXBkX3NldHVwX2JzczogSW50ZXJmYWNlIHdsYW4x
IHdhcyBhbHJlYWR5IHN0YXJ0ZWQKU3VuIFNlcCAyOCAwNDowNDozNiAyMDI1IGRhZW1vbi5lcnIg
aG9zdGFwZDogSW50ZXJmYWNlIGluaXRpYWxpemF0aW9uIGZhaWxlZApTdW4gU2VwIDI4IDA0OjA0
OjM2IDIwMjUgZGFlbW9uLm5vdGljZSBob3N0YXBkOiB3bGFuMTogaW50ZXJmYWNlIHN0YXRlIERG
Uy0+RElTQUJMRUQKU3VuIFNlcCAyOCAwNDowNDozNiAyMDI1IGRhZW1vbi5ub3RpY2UgaG9zdGFw
ZDogd2xhbjE6IEFQLURJU0FCTEVEClN1biBTZXAgMjggMDQ6MDQ6MzcgMjAyNSBkYWVtb24ubm90
aWNlIGhvc3RhcGQ6IHdsYW4xOiBpbnRlcmZhY2Ugc3RhdGUgRElTQUJMRUQtPkRGUwpTdW4gU2Vw
IDI4IDA0OjA0OjM3IDIwMjUgZGFlbW9uLm5vdGljZSBob3N0YXBkOiB3bGFuMTogREZTLUNBQy1T
VEFSVCBmcmVxPTU1ODAgY2hhbj0xMTYgY2hhbl9vZmZzZXQ9MCB3aWR0aD0zIHNlZzA9NTYxMCBz
ZWcxPTAgY2FjX3RpbWU9NjBzCgoKCgo=
--00000000000034a93c0644fa0334--


