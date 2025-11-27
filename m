Return-Path: <linux-wireless+bounces-29386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B96C8F455
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 16:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12CAA341EB4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9342494FF;
	Thu, 27 Nov 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="Iq2jQwiM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043ACEACE;
	Thu, 27 Nov 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257432; cv=none; b=nizwvoMRgVX/IqjJTxiOXwK657tVAoTvLJERXQOTmK3SdCxxQqzrx5m0r+wm4hdG7KyAprZTf/L3jbxw5zMwLPsCwJuxNiJFkf4KOiTrXmIkx+fd3dWpudRucMFD/Tc/dy03WwzEo7QRQxnxt3SD7FKxA/X5xGM/y441CNslErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257432; c=relaxed/simple;
	bh=SNgekyZISVjxqm05oCPnxWNr0tSC3ioQWMN6SqIjea0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:Subject:To:
	 References:In-Reply-To; b=toYqIVSheA6dA1xDagXsEOEsOGDX86vxwzAC6bsb4WrjsQsriwxcKLX8UYA+ejZM2G7VCjM9bCDmg0f2LedqqrpV+FEog3Qc96GoTyp3wSJ4dq7m2HtzADjten97GD00BBs+RZASokFoNrNT86WEVLv1w6LDH7kHdxdbANS/sqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=Iq2jQwiM; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560+5C/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1764257355; x=1765557355;
	bh=SNgekyZISVjxqm05oCPnxWNr0tSC3ioQWMN6SqIjea0=; h=From;
	b=Iq2jQwiMkEupB6ek14Ce9g+vzS695Dld/mYbROgXY5HV05aKY1uf5WgGM9SgPS4oj
	 BjAdt+Y4gDElC7WIlQiD1UZ0JKPSaRYy73kVRi7GkUHmxmLGp0kvCXo4STQeaT1et/
	 2KHhZpEx+x2rclO9FG2fMtyypT+pgidn7MMbr4NW8kOPT3xMmc69keOhfdJHYe8W7u
	 EuHLaR5s1lNnqmEOW7U1g2dJIt+7vaMSOIDYYgE0DYdBMgI635NUE5lA5wq+jTk0fm
	 a3YO4bLStTFVVuQEiW2fPSVOw0dVGdjHP2fXG0q9yUoux2ivIh1olMaq0IOrgp5tJV
	 ARSc5uU222j8Q==
Received: from localhost (nat2.prg.suse.com [195.250.132.146])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.18.1/8.18.1) with ESMTPS id 5ARFTCcb000418
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 16:29:13 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 16:29:12 +0100
Message-Id: <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
        "Karel Balej" <balejk@matfyz.cz>, "Jeff Chen" <jeff.chen_1@nxp.com>,
        "Peng
 Fan" <peng.fan@nxp.com>, <david@ixit.cz>
Subject: Re: [DONOTAPPLY RFC PATCH v2 0/4] WiFi support for
 samsung,coreprimevelte
To: "Johannes Berg" <johannes@sipsolutions.net>,
        "Rob Herring"
 <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>,
        "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement"
 <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth"
 <sebastian.hesselbarth@gmail.com>,
        "Brian Norris"
 <briannorris@chromium.org>,
        "Francesco Dolcini" <francesco@dolcini.it>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, "Frank Li" <Frank.Li@nxp.com>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>
References: <20251026182602.26464-1-balejk@matfyz.cz>
In-Reply-To: <20251026182602.26464-1-balejk@matfyz.cz>
X-Spam-Level: ****

Hello,

Karel Balej, 2025-10-26T19:20:37+01:00:
> this series adds support for WiFi to the samsung,coreprimevelte
> smartphone (and can be straightforwardly reused for the other known
> Marvell PXA1908-based smartphones).
>
> The series is currently not intended for application as indicated in the
> subject prefix as the firmware necessary for the operation of the chip is=
 not
> available in linux-firmware.
>
> Instead, my intentions are to publish the recent developments regarding
> the chip support (see the third patch of the series) and offer them for
> others to use and if possible get some feedback on them and also
> hopefully to spark some conversation with NXP regarding getting the FW
> into linux-firmware which would allow this series to be mainlined.
>
> Regarding the firmware I have been in contact with Jeff Chen of NXP some
> time ago who promised to ask about it internally =E2=80=93 I am thus now =
gently
> reminding Jeff of the matter. I will also appreciate input from anyone
> else who may help with upstreaming whichever version of the firmware.
>
> The trouble of upstreaming the FW is mostly a legal one (although an up
> to date version of it would also be very welcome) as it is available as
> part of the stock Android of the devices with this chip and can thus be
> used on individual basis, it cannot however be submitted to
> linux-firmware by myself for instance as the license is not known
> (although probably is the same as for the other blobs in the mrvl
> directory) and as the submission would require a sign-off from someone
> involved with NXP.
>
> The third patch in this series fixes a serious issue with the WiFi
> observed on the phone (see the relevant commit message). The form is
> however not directly usptreamable and it is not clear to me how to best
> make it be since it involves changing a data type which probably cannot
> be easily be special-cased for the new chip and would likely break the
> other chips the mwifiex driver supports if applied as is. I will thus
> welcome suggestions on this, although I'm also hopeful that a possible
> reasonably up to date FW would not require this workaround at all.
>
> The series is based on the pxa1908-dt-for-6.19 tag of Duje's tree [1] as
> it contains the necessary SDIO description in the phone's device tree.
>
> I have not applied the trailers sent in response to v1 as it has been
> some time and as this is not expected to be applied anyway.
>
> [1] https://gitlab.com/pxa1908-mainline/linux/-/commits/pxa1908-dt-for-6.=
19

could I please get some feedback on this?

Mainly I'm wondering whether there is some way I could get this in (the
basic support, without the hack in the third patch) without the firmware
as I have unfortunately not been successful in my communication with NXP
yet.=20

To reiterate, the firmware is generally available but is not part of
linux-firmware and the entire process of upstreaming the chipset support
is stuck on that.

Thank you, best regards,
K. B.

