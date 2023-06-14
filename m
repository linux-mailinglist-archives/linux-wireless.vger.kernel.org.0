Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069F672FA04
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbjFNKDz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbjFNKDy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 06:03:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2C3195
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7ueXqaJVw9TBVsGoOgb7NvOZPv0Y6YnJX85IBDw9MxA=;
        t=1686737033; x=1687946633; b=yHH9zYc6kCcTuNr+pfa2olkk5hjIkWhAyypwtWx6dBm+tlG
        +xPE9s8SfWl1xmbXpJLpJek8Wqn2rRoEjo4woFzS45kyNI7uwABYLTeNnWQya9DKfWno1yvLPwDgu
        w9zZHDiL9t7f8e+ucdOZOyDZCu/TAJhGOUpEnLSalk0o3sC1eRT9xCEnH+Hx5Vj1XXRaw2ZSPoArK
        3XvhWUbLKqI4SGE6dDMgABszpT978J7BDiaUJOZ2iloJqnFtRerGG+ZseiljbvmqC85QR2BKN7MjN
        M9aCkXwouJiJF+kwB9CYotViSYtR9+kRyrInGsdzob30aPud7X/6hJ73yTZwbC+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9NLz-0063m7-0y;
        Wed, 14 Jun 2023 12:03:51 +0200
Message-ID: <31903d55380fae200aad3626308e5b48f05dc14b.camel@sipsolutions.net>
Subject: Re: [PATCH 02/15] wifi: iwlwifi: mvm: debugfs: add entry for
 setting maximum TXOP time
From:   Johannes Berg <johannes@sipsolutions.net>
To:     gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>
Date:   Wed, 14 Jun 2023 12:03:50 +0200
In-Reply-To: <20230612184434.4ab332037a25.I57c33574a61edd68bd0ec1aa7009f31111fd7efe@changeid>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
         <20230612184434.4ab332037a25.I57c33574a61edd68bd0ec1aa7009f31111fd7efe@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-06-12 at 18:51 +0300, gregory.greenman@intel.com wrote:
> From: Avraham Stern <avraham.stern@intel.com>
>=20
> Add an entry for setting the maximum TXOP time in microseconds.
> The configured value can be read from the same entry.
>=20
> Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>  .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 38 +++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++
>  .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  3 ++
>  3 files changed, 44 insertions(+)
>=20
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drive=
rs/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
> index 3613b1fdc5d9..762bce70e262 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
> @@ -679,6 +679,42 @@ static ssize_t iwl_dbgfs_quota_min_read(struct file =
*file,
>  	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
>  }
> =20
> +static ssize_t iwl_dbgfs_max_tx_op_write(struct ieee80211_vif *vif, char=
 *buf,
> +					 size_t count, loff_t *ppos)
> +{
> +	struct iwl_mvm_vif *mvmvif =3D iwl_mvm_vif_from_mac80211(vif);
> +	struct iwl_mvm *mvm =3D mvmvif->mvm;
> +	u16 value;
> +	int ret;
> +
> +	ret =3D kstrtou16(buf, 0, &value);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&mvm->mutex);
> +	mvmvif->max_tx_op =3D value;
> +	mutex_unlock(&mvm->mutex);

This is a strange debugfs file, it only takes effect the next time
iwl_mvm_rs_fw_rate_init() is called, which can be kind of random? Seems
like it should force a reinit?

johannes
