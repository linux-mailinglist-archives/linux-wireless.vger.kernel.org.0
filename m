Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510D4D5BDD
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 09:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfJNHHr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 03:07:47 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:48692 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfJNHHr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 03:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1571036865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axC+jM4ADqxgdZJ1iBxOf/jTq46214TEMAimEqIXNSc=;
        b=MDel8nDR21+wfafqAJXW1f0RGPFbIWDMQ/92nyka1xYDL7yF20tVInjdlxGyGzJnLvr4+L
        aqaN6zA+zuopcXZ5iQ93FyKr3xdcf1aDpMgT1xYcWEWgXUH7X7Z06mHVj7nmvk4eMQWvue
        5ZshFriTeYLmL9+GxkV0naLBUPTbr7I=
From:   Sven Eckelmann <sven@narfation.org>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     ath10k@lists.infradead.org, vnaralas@codeaurora.org,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] ath10k: provide survey info as accumulated data
Date:   Mon, 14 Oct 2019 09:07:42 +0200
Message-ID: <1614044.H5m0Cyd3Ly@bentobox>
In-Reply-To: <9a9ec99b-9643-7288-eed5-b549a9fe1487@newmedia-net.de>
References: <20190918124259.17804-1-sven@narfation.org> <9a9ec99b-9643-7288-eed5-b549a9fe1487@newmedia-net.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3096302.iHDqCeegG6"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3096302.iHDqCeegG6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 14 October 2019 00:15:20 CEST Sebastian Gottschall wrote:
> i checked your patch on 10.4 based chipsets with 9984. the values are 
> now looking bogus and wrong at all. busy and active time time in ms does 
> increase in hours each second
> the problem seem to be that your patch is 10.2.4 only related. 
> ath_clean_survey does not trigger on 10.4 so the values double itself 
> each time the event raises since you add the full values and not just a 
> delta on top

Thanks for the feedback. So we have now a firmware 10.2.4 which is counting 
busy + active up and has wraparound problems. And then we have a 10.4 firmware 
(on QCA9888 and QCA4019) which is clearing everything as expected with 
WMI_BSS_SURVEY_REQ_TYPE_READ_CLEAR  and then we have some 10.4 firmware (one 
QCA9984) which behaves more like ath 10.2.4 firmware but is marked as 
ATH10K_HW_CC_WRAP_SHIFTED_EACH like the QCA4019.

So I have no idea how to fix this when QCA4019 and QCA9984 are currently 
marked the same but behave differently. Does somebody have a overview how the 
different HW versions should behave or is there some special bit in the data 
reported by the firmware which can be used to evaluate the expected behavior?

Kind regards,
	Sven
--nextPart3096302.iHDqCeegG6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl2kHr4ACgkQXYcKB8Em
e0Y0gA/+J3vh6vqdz7b6HrkGIgGPto8oO94eyZVurrnv2bQg6wZtGaBZsiw0c0Fg
+kl6b+xDAOwy2WzfEEqZUAY1Wkbdub7MHG41dLJ2sJ8UvARksGNuPx6qT16yseHY
ewaTaIdBb6cIQmb/HewibxC8sIeLAz2s0Qj4UPxqlnmgRiEK39VHZ3tyGD1uptcH
Br0SkxDg4nTvIKqvNVHRIq8iduM+InK0mMl3WXV+/Q0ax93CR3wfStHE0G2hP9ep
fO1ZWdgPtw4Do9RRh9j+0K6eEmyA/EhDy6kTYptonIRcz9+yRRS8OhNtg+8xrwIk
0nPhlBKpvZKcSDhISyJfakbktXVFuEYaPgJXilBK7AjVPIUxS+9VVCR1v1AxA/Ep
CcDn/akUBbFf4s6/HD2kiQUEghfxrPp4lt0qqBb0Mbe4eDjVlAtbQFQll1RyOf9F
Vf2K/0I/bdIG/TCAu7qDLJqypUdjOSUAYxBe2tkuewkLji+xFg61Z9J8Pdb/gFUZ
ba/tacoXY1gRF+56yaj07WlJg1GcKtMWNmP+531awg/sSm7v1M89qhXM5kqMAc9H
5dIt1m/rSiTDW9zjOUS1Rh0WtUnZYqG4MKZNxLqasat9rwW3it9PPCHykTlDmHay
OtZakA1Y43+fELFCVsJgJnfPC6y3F0o6FFHL1pXCIvI4+JfEUIQ=
=GLvq
-----END PGP SIGNATURE-----

--nextPart3096302.iHDqCeegG6--



