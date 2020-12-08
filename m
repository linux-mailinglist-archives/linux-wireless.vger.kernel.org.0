Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA772D2693
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 09:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgLHIua (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 03:50:30 -0500
Received: from ozlabs.org ([203.11.71.1]:60591 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgLHIua (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 03:50:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cqv4q2vXrz9sWK;
        Tue,  8 Dec 2020 19:49:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1607417387;
        bh=m50Uy9hZiiibvZwbvLRlzopRh9M4axzuEr+t92E0AW0=;
        h=Date:From:To:Cc:Subject:From;
        b=q+7saXO5Plf/h5DonDEbRrA4oO7G3oool0uv1pt8FNgE8QAEeoGNqACpl3PkjaKGJ
         5UqrpOBcLOJ27uX2wPDfHqeBJmaho8GyZRLc1Fzqv0/7+WVQ7C5BWw2hikjoH5QVv+
         hb1J33NjF7DJ9MlTelKrdw7uFzaJu5X55AV3/1lCQEKcMzRmgnJBRW/eUiKl8ZYfDY
         7x4EIucPo81hVt8nIX8KE+oAym3mBjvNSkj4kn+VT3A9cFzTmr5OrXErt+1pyn92dW
         zQ0V11Lpeh5PQEqwrCsMlJuDMRy2HK/zEFa4O9YtXcDYj7KUphBkTGvaNMAbVCZEiw
         LawUXFfMU4ZGg==
Date:   Tue, 8 Dec 2020 19:49:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the wireless-drivers-next
 tree
Message-ID: <20201208194944.19ee46f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2HR/L28mlXBwHzQoeCzS3l1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/2HR/L28mlXBwHzQoeCzS3l1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-drivers-next tree, today's linux-next build
(powerpc allyesconfig) failed like this:

ld: drivers/net/wireless/realtek/rtw88/rtw8822ce.o:(.rodata.rtw_pm_ops+0x0)=
: multiple definition of `rtw_pm_ops'; drivers/net/wireless/realtek/rtw88/r=
tw8822be.o:(.rodata.rtw_pm_ops+0x0): first defined here
ld: drivers/net/wireless/realtek/rtw88/rtw8723de.o:(.rodata.rtw_pm_ops+0x0)=
: multiple definition of `rtw_pm_ops'; drivers/net/wireless/realtek/rtw88/r=
tw8822be.o:(.rodata.rtw_pm_ops+0x0): first defined here
ld: drivers/net/wireless/realtek/rtw88/rtw8821ce.o:(.rodata.rtw_pm_ops+0x0)=
: multiple definition of `rtw_pm_ops'; drivers/net/wireless/realtek/rtw88/r=
tw8822be.o:(.rodata.rtw_pm_ops+0x0): first defined here
ld: drivers/net/wireless/realtek/rtw88/pci.o:(.rodata.rtw_pm_ops+0x0): mult=
iple definition of `rtw_pm_ops'; drivers/net/wireless/realtek/rtw88/rtw8822=
be.o:(.rodata.rtw_pm_ops+0x0): first defined here

Caused by commit

  2e86ef413ab3 ("rtw88: pci: Add prototypes for .probe, .remove and .shutdo=
wn")

I have applied the following patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 8 Dec 2020 19:35:18 +1100
Subject: [PATCH] rtw88: pci: "extern" is necessary for header declarations =
of data

Fixes: 2e86ef413ab3 ("rtw88: pci: Add prototypes for .probe, .remove and .s=
hutdown")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/wireless/realtek/rtw88/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireles=
s/realtek/rtw88/pci.h
index cda56919a5f0..7cdefe229824 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -214,7 +214,7 @@ struct rtw_pci {
 	void __iomem *mmap;
 };
=20
-const struct dev_pm_ops rtw_pm_ops;
+extern const struct dev_pm_ops rtw_pm_ops;
=20
 int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 void rtw_pci_remove(struct pci_dev *pdev);
--=20
2.29.2

--=20
Cheers,
Stephen Rothwell

--Sig_/2HR/L28mlXBwHzQoeCzS3l1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/PPigACgkQAVBC80lX
0Gy2FQf+PxaKbTnyOH0/6sZ9BmI4PsmGjnAZIr/LuB50TvMb993fvkLPw3MBK7vK
wqgDFydXtIQNciPgpFGQYa+ngc491YTNCRwTPEEeXSvQ8tU/sztf/1+NQrzzD/F+
Yd/Cg4oTG9LguDPKBIFJOdZYPZinjKLj7HvXsbCEgA/Aw+660nSZYShlQ209mU3a
pmWLVvOdRZg9Pi0yMxoDj/geZQAA+G+lMRePbFw51RI8T/oooEwwyKWy/2L7CQnt
sVQ0HZAfLoFUA1IWfa+nskV6YfJbn5zclOu6tJpkoNkdtrSYDkndkU5QqIaFL4k8
NkhQWzbBTU79TC6NQozHthlS5/V18g==
=gl18
-----END PGP SIGNATURE-----

--Sig_/2HR/L28mlXBwHzQoeCzS3l1--
