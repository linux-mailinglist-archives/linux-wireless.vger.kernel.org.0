Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A7CEA81A
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 01:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfJaANZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 20:13:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbfJaANZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 20:13:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 473QlQ0XW3z9sPj;
        Thu, 31 Oct 2019 11:13:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572480802;
        bh=j2atfhGE6NXcq9SsnucOtdA7E+v4LMToTw1N5o0kYFc=;
        h=Date:From:To:Cc:Subject:From;
        b=U+o6y/sWnw3QXAj6lJxJeJOr85tZ3DbGK9PzvjHzQvWQNVE6rQJG2PKsBofyfz96j
         m4ZO0wH5C7kojPUJu5z98mXAwggN2Pv/s+KQBmH7ZtMUG6GesNzsNYYPCjcqpyxqsE
         8B91ZSQ3VYXuN0GRe7Rr00R5ji56SuBPqFBHiY/ToPRqnGIIIbxH9MkVo9lI5sjBFr
         ynOfRe4y+kbe7o3zV+ahIiu+9rSFW5oitCN+LA8aTQkYd7GTTKJasSVAKwEU8H5lC7
         kQ/9cBsMD2S9xRI411Eh4M6w7dG9s58T9mxWCDR29Tsp4uDSSxZoS5trqj4/JvNiLR
         r8paC7YEqUdpg==
Date:   Thu, 31 Oct 2019 11:13:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>,
        Tova Mussai <tova.mussai@intel.com>
Subject: linux-next: manual merge of the wireless-drivers-next tree with the
 wireless-drivers tree
Message-ID: <20191031111242.50ab1eca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o6YZWLscK0mtaqIJjxT09ev";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/o6YZWLscK0mtaqIJjxT09ev
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-drivers-next tree got a
conflict in:

  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h

between commit:

  3d206e6899a0 ("iwlwifi: fw api: support new API for scan config cmd")

from the wireless-drivers tree and commit:

  65b9425ce9aa ("iwlwifi: rx: use new api to get band from rx mpdu")

from the wireless-drivers-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 5ca50f39a023,a25712cce4ab..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@@ -1405,12 -1409,12 +1409,18 @@@ static inline bool iwl_mvm_is_scan_ext_
  			  IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER);
  }
 =20
 +static inline bool iwl_mvm_is_reduced_config_scan_supported(struct iwl_mv=
m *mvm)
 +{
 +	return fw_has_api(&mvm->fw->ucode_capa,
 +			  IWL_UCODE_TLV_API_REDUCED_SCAN_CONFIG);
 +}
 +
+ static inline bool iwl_mvm_is_band_in_rx_supported(struct iwl_mvm *mvm)
+ {
+ 	return fw_has_api(&mvm->fw->ucode_capa,
+ 			   IWL_UCODE_TLV_API_BAND_IN_RX_DATA);
+ }
+=20
  static inline bool iwl_mvm_has_new_rx_stats_api(struct iwl_mvm *mvm)
  {
  	return fw_has_api(&mvm->fw->ucode_capa,

--Sig_/o6YZWLscK0mtaqIJjxT09ev
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl26Jw8ACgkQAVBC80lX
0Gzangf+PVr7ZAapuPg08fLs9Ey4KAD9IZj69wOiWkwcAgzfmNfMOU2fZEhehMSn
acO+G7BoN3n/2NnlxcASOz+Vq3r86yyidVXQASvYDnLsC7/l7LGgL+L/HcpyfC3a
CHxdZyFPf/GtzQSRtwkpBllqr9LhkyzqCZwPswDHj6u8KN4F1kcJlVj3JyspALxY
pfOCE0bSMaXCNCGuYkGiyjUCksNq5lOUCbW5e3dHk2H8aTqVbySDM0lA/shcduBX
TW8awsQ/PwHloI9Hu6eJeF2yZ7kP234C4bmuCP1bP0v4qw831DrL3MsNvIGUO2oh
MW9Hd/RHZVwkkvxKGnJnuu9NUcVvkQ==
=Idae
-----END PGP SIGNATURE-----

--Sig_/o6YZWLscK0mtaqIJjxT09ev--
