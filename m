Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1D49E4EE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 11:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfH0JxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 05:53:18 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:57348 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfH0JxS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 05:53:18 -0400
Received: from bentobox.localnet (p200300C5970B0CE86C4047C4D7108D73.dip0.t-ipconnect.de [IPv6:2003:c5:970b:ce8:6c40:47c4:d710:8d73])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 0CE861FFBA;
        Tue, 27 Aug 2019 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1566899595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRwu4UqyGupIMo78TUJ7pXX9uV7Eu7K7SpIEb55MAHg=;
        b=0+K7t3itbStnxDG8MPwrMRtDrYwBv58itOCXUTr/DK3mXARNmE9mWCshQLXU0B1Qy3ApIE
        7UEzGverpywq5VAs3pWGDBohApC5IVOMfws4rK/4K83nXG4PVoK2jCQ3rjm/QiiCU4DNg1
        d2tXMNTOrT655tQbUgPcraJAVnDPDVc=
From:   Sven Eckelmann <sven@narfation.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 10/49] ath11k: add debug.c
Date:   Tue, 27 Aug 2019 11:53:09 +0200
Message-ID: <18655975.RomJW5s5WE@bentobox>
In-Reply-To: <6622b83f754404ec05b9442027757c5e@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org> <4441194.D8eDD6Tzdi@bentobox> <6622b83f754404ec05b9442027757c5e@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5313933.ePln27GtoC"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1566899595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRwu4UqyGupIMo78TUJ7pXX9uV7Eu7K7SpIEb55MAHg=;
        b=QWRecsNxTyISxnMFJqrFz5oIkSEVv6+IgiZUmwQ/E+l/b+REQypeguJUiQmtVt+8yQBbOV
        YlOTF16RueLELh2VAitLBCHYLPdcd+j6xa9cqKKK7vv7bA8IG07Xi0D3TG1+qQ/EFFAq1G
        kSBYwARmRDWl3TANYHrJYoqqmKE4TTg=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1566899595; a=rsa-sha256;
        cv=none;
        b=lr4AzzJ06sE6C8iPE0iKSt0pSs6/ka+v5C/Gv6pjokcQt4MgbX0LuC/6nC1jeMx0CWXFSw
        aXs9BUIRV6gitrulSr5d16Rc0mr5jd4qf9vcsakcXmPQP2HPYtY1rN5Dpe+m8Qwu+53jGP
        O1fTAK1mfGcVGLEFhNlWeKskJKXsRJ0=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart5313933.ePln27GtoC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 27 August 2019 11:04:23 CEST Anilkumar Kolli wrote:
[...]
> > Yes, but it shouldn't kill the complete system.
> > 
> This will not kill the whole system, This will crash target and we have 
> mechanism to recover the system.
> 
> Hope u have generated the crash with below patch,
> https://source.codeaurora.org/quic/qsdk/oss/system/feeds/wlan-open/tree/mac80211/patches/019-ath11k-disable-q6-recovery-to-crash-kernel.patch?h=win_ap.1.0
> 
> Please remove this patch to see the target recover after the crash.

John also pointed me to this patch yesterday and I have now removed it.

But the wifi hardware doesn't recover after issuing an assert. All(?) firmware 
request will just timeout:

    [ 1093.114530] ath11k c000000.wifi1: wmi command 20488 timeout
    [ 1093.114555] ath11k c000000.wifi1: failed to send WMI_VDEV_SET_PARAM_CMDID
    [ 1093.118903] ath11k c000000.wifi1: Failed to set dtim period for VDEV 0: -11
    [ 1096.124532] ath11k c000000.wifi1: wmi command 20488 timeout
    [ 1096.124554] ath11k c000000.wifi1: failed to send WMI_VDEV_SET_PARAM_CMDID
    [ 1096.128902] ath11k c000000.wifi1: Failed to set CTS prot for VDEV: 0
    [ 1099.134527] ath11k c000000.wifi1: wmi command 20488 timeout
    [ 1099.134547] ath11k c000000.wifi1: failed to send WMI_VDEV_SET_PARAM_CMDID
    [ 1099.138895] ath11k c000000.wifi1: Failed to set preamble for VDEV: 0
    [ 1102.144526] ath11k c000000.wifi1: wmi command 20488 timeout
    [ 1102.144546] ath11k c000000.wifi1: failed to send WMI_VDEV_SET_PARAM_CMDID
    [ 1102.148894] ath11k c000000.wifi1: failed to set mgmt tx rate -11
    [ 1105.154526] ath11k c000000.wifi1: wmi command 20488 timeout
    [ 1105.154547] ath11k c000000.wifi1: failed to send WMI_VDEV_SET_PARAM_CMDID
    [ 1105.158895] ath11k c000000.wifi1: failed to set beacon tx rate -11
    [ 1114.164529] ath11k c000000.wifi1: wmi command 16387 timeout
    [ 1114.164553] ath11k c000000.wifi1: failed to send WMI_PDEV_SET_PARAM cmd
    [ 1114.168899] ath11k c000000.wifi1: Failed to set beacon mode for VDEV: 0
    [ 1117.174527] ath11k c000000.wifi1: wmi command 28675 timeout
    [ 1117.174550] ath11k c000000.wifi1: failed to send WMI_BCN_TMPL_CMDID
    [ 1117.178899] ath11k c000000.wifi1: failed to submit beacon template command: -11
    [ 1117.185231] ath11k c000000.wifi1: failed to update bcn template: -11
    [ 1120.184524] ath11k c000000.wifi1: wmi command 20488 timeout
    [ 1120.184545] ath11k c000000.wifi1: failed to send WMI_VDEV_SET_PARAM_CMDID
    [ 1120.188893] ath11k c000000.wifi1: Failed to set dtim period for VDEV 0: -11
    [ 1123.194527] ath11k c000000.wifi1: wmi command 20488 timeout
    [ 1123.194548] ath11k c000000.wifi1: failed to send WMI_VDEV_SET_PARAM_CMDID
    [ 1123.198895] ath11k c000000.wifi1: Failed to set CTS prot for VDEV: 0
    [ 1126.204526] ath11k c000000.wifi1: wmi command 20488 timeout
    [ 1126.204547] ath11k c000000.wifi1: failed to send WMI_VDEV_SET_PARAM_CMDID
    [ 1126.208894] ath11k c000000.wifi1: Failed to set preamble for VDEV: 0
    [ 1129.214527] ath11k c000000.wifi1: wmi command 20488 timeout
    [ 1129.214548] ath11k c000000.wifi1: failed to send WMI_VDEV_SET_PARAM_CMDID
    [ 1129.218897] ath11k c000000.wifi1: failed to set mgmt tx rate -11
    [ 1132.224525] ath11k c000000.wifi1: wmi command 20488 timeout
    [ 1132.224546] ath11k c000000.wifi1: failed to send WMI_VDEV_SET_PARAM_CMDID
    [ 1132.228894] ath11k c000000.wifi1: failed to set beacon tx rate -11

ath11k must be unloaded + loaded again to fix this problem.

Kind regards,
	Sven
--nextPart5313933.ePln27GtoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1k/YUACgkQXYcKB8Em
e0beEg/9EoDNNOQpVYO5gzr4xJXJN0DG/oKE6/43GxIJlVXRngszuFFNVQ/pB2iR
1/TP85ZBy6uHIhuRbioU86zvWJyA7FUXaDYHSgRKmpH/4XXOSZebl/fFNGngdz3Z
/VtF1MTUqAoAci8dUPISJ8IW0RRTqoswS2zHxsRr57WH5fjESqVkbubIEaHe1FMz
MwPplu5G81X3H0p9E+IgtE8Wt2+cs+tKZqg3uLSX5tc7MkB4wb/Z8hGI7gtadtDf
tXnKIVncWIYFKDcaHIcv5HWXisp0zR8YXlPloPJ9HUHw8oVieqO4N8PZMwDgBWdd
Kt3N8bJivn77c2Zanyw63zW/RA6knTi6ifCghGKR/V+llrEMeM04/ILuZQvyjGag
2mefYNsv5STHVcOHtswWt/Mvv7hKF8tJZ6fkgHX4AxyGTAlc7JyXbnbnKSX94Jaz
9pZwLN2v4YiOgdC6s+cKVUy4l6WPXyErED65NFGbBb9v4eTJJz4jfZ5otpjt+BJs
bPzyrLaiNR4FRjSoDOB/e34Eny/2xx/a9kh6Jkxx86HmZ2UP47cUuhcPXWDyObVD
Yyc/VxV/gzvzcw6lJmY/PYgNrJvm0bSN5OYaMF192rFCGJLMqbQpGJJ83fe2moU1
YjnuvEwjumusLqlgcnoJFIHzOfWL5hXHM9q4AKwaLUe/A5HQ4nU=
=WXO1
-----END PGP SIGNATURE-----

--nextPart5313933.ePln27GtoC--



