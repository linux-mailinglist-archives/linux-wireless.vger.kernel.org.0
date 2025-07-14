Return-Path: <linux-wireless+bounces-25361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F154B03BCF
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 12:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9E41888D90
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2A91FE461;
	Mon, 14 Jul 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Kf2Hvvfq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FD5680
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488643; cv=none; b=HTMK2CDOyKSKdPxvGCLbYjXCdMk6VQQtRlyhgXbolACFebDqAmb8c7xbRkPAX3DUWw9Rm10mrjIHoeSMJQdEDleDSpLxWDOhlawcKQuHiKArGVAySOLZTunsODVkobz3Kkmdr4ls/MYccjIZspRUg5SsJe5nNiavwttWhyRAel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488643; c=relaxed/simple;
	bh=v3ib+n5KBEplv3znbXQMFyTYtzf8xAFu+7J2QtLENF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M1SdxeFHA8U2irfyXfceLEIqSl/YosGv6ukKqpYfNc3iPpZGWfrGZV7aiwBLDiU66W+UUTNkm0/giAklcDZYj955P5uxcQKAVmfCjrzMaSD7XSwcW/rufT4wFwzv4IxUI8PDMI+3QEZRpgqqnU5FImFF07YaKE88WdweySujyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Kf2Hvvfq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xZASNjCO0eECpH3/s9I72OwHT1Hu0cXixi+FRwXIYaY=;
	t=1752488642; x=1753698242; b=Kf2Hvvfq//LDjDuqGYYtbT252S93jBYcvEN8iuPu93zjwpG
	SMvkB2GjCddYS9rsq21sC0oGbDiDvIgojiqCLfhFXoi9siuL1nX7c3+ejdLVPt1IKp3j7fIYpf0D6
	p4NMwpm/2MDQUfccvu9J5Bknw0aPS/y4GWTcD3JhEOEQMKmZcAR8frpU9WG/D7rQe61TJRZHq+0l8
	8t8+WBDcTys4l1NmNXM1wn2urUKs59a9zkvs6GO9NEFqOz2eYjPvxRhDD2iv8ITo+PMHsFQsGNsxY
	oeIuz5Yghc8PLW8otZt1TKF/qpiN6AYHCeEqjVQtTQBy89mCY6dOPCpBHfigGxlg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubGLd-00000003tn7-0q1M;
	Mon, 14 Jul 2025 12:23:50 +0200
Message-ID: <253456e43cba4c721047076ff32dde8851b1ac32.camel@sipsolutions.net>
Subject: Re: Disconnection triggered by Puncture advertisement
From: Johannes Berg <johannes@sipsolutions.net>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Date: Mon, 14 Jul 2025 12:23:46 +0200
In-Reply-To: <652c3aa7-dee6-470c-b5dc-638198990192@oss.qualcomm.com> (sfid-20250714_120929_502816_71F66BCB)
References: <e80d5786-b1c1-46f5-b723-e6197e2d06e9@oss.qualcomm.com>
	 <e713c376c01a81dd21d928e5d84bd3a1ae9e6613.camel@sipsolutions.net>
	 <652c3aa7-dee6-470c-b5dc-638198990192@oss.qualcomm.com>
	 (sfid-20250714_120929_502816_71F66BCB)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-07-14 at 18:09 +0800, Baochen Qiang wrote:
> > > This 'punctured' is suddenly (I mean even 'EHT Operation' was not see=
n in previous
> > > beacons)
> >=20
> > Pretty sure there must've been EHT operation before, otherwise we
> > couldn't connect with EHT, and you had multi-link.
>=20
> Sorry for misleading, I was not clear. I was trying to say 'EHT Operation=
 Parameters' in
> beacon was always 0 AFTER AssocResp, until this sudden 'punctured' frame.
>=20
> Of course 'EHT operation' was always seen in the beacon frames.

Right, OK.

[snip]

AP information:

>         Tag: HT Information (802.11n D1.10)
>             Tag Number: HT Information (802.11n D1.10) (61)
>             Tag length: 22
>             Primary Channel: 36
>             HT Information Subset (1 of 3): 0x05
>                 .... ..01 =3D Secondary channel offset: Secondary channel=
 is above the
> primary channel (0x1)
>                 .... .1.. =3D Supported channel width: Channel of any wid=
th supported

So HT is 40 MHz, that's of course fine.

>         Tag: VHT Operation
>             Tag Number: VHT Operation (192)
>             Tag length: 5
>             VHT Operation Info
>                 Channel Width: 80 MHz, 160 MHz or 80+80 MHz BSS Bandwidth=
 (1)
>                 Channel Center Segment 0: 42
>                 Channel Center Segment 1: 0

VHT is 80 MHz (the 160 thing there is misleading) if the primary channel
is 36 and the overall center is 42:

| 36 | 40 | 44 | 48 |
          42

>         Ext Tag: HE Operation
>             Ext Tag length: 6 (Tag len: 7)
>             Ext Tag Number: HE Operation (36)
>             HE Operation Parameters: 0x003ff4
>                 .... .... .... .... .... .100 =3D Default PE Duration: 4
>                 .... .... .... .... .... 0... =3D TWT Required: Not requi=
red
>                 .... .... ..11 1111 1111 .... =3D TXOP Duration RTS Thres=
hold: 1023
>                 .... .... .0.. .... .... .... =3D VHT Operation Informati=
on Present: False
>                 .... .... 0... .... .... .... =3D Co-Hosted BSS: False
>                 .... ...0 .... .... .... .... =3D ER SU Disable: False
>                 .... ..0. .... .... .... .... =3D 6 GHz Operation Informa=
tion Present: False
>                 0000 00.. .... .... .... .... =3D Reserved: 0x00
>             BSS Color Information: 0x36
>             Basic HE-MCS and NSS Set: 0xfffc

He doesn't say anything but it actually cannot unless it were on 6 GHz,
so that's fine.


So yeah, the AP is misbehaving. Now you might argue that as we have EHT
we shouldn't care? Dunno. But basically we don't want to initially
_connect_ to such an AP that's confusing itself with puncturing ... we'd
connect with HE since there it says no puncturing. But while maintaining
the connection because of the code structure it suddenly looks like it
"lost" EHT because the EHT was not well-implemented and we ignore it ...

> > I don't know. I have a feeling that perhaps the AP is misbehaving and
> > setting HE operation to 80 MHz as well (which is invalid if EHT
>=20
> So what's the expected bandwidth in HE Operation? 40 MHz or less?

Whatever narrowing of the bandwidth is needed to not include the
subchannels disabled by puncturing. Could be 40, or could perhaps even
be 20 if the puncturing bitmap was 0x2 instead of 0x8.

After all, an HE client knows nothing about puncturing, so it will
always use the full bandwidth advertised, if something is punctured in
the HE part of the channel that's the entirely wrong thing for it to do.

Btw, this is also covered by the spec (I have P802.11be/D7.0 at hand
right now):

35.15.1 Basic EHT BSS operation
[...]
If a BSS operating channel width is announced in the EHT Operation
element, then an EHT AP shall announce the BSS operating channel
width(s) to non-EHT non-AP STAs with the following restrictions:

- [...]
- If the Disabled Subchannel Bitmap subfield in the EHT Operation
  element is present, the announced BSS operating channel width(s) to
  non-EHT non-AP STAs is the maximum width including the primary channel
  without covering any punctured 20 MHz subchannel indicated in the
  Disabled Subchannel Bitmap subfield in the EHT Operation element as
  defined in 35.15.2 (Preamble puncturing operation).

johannes

