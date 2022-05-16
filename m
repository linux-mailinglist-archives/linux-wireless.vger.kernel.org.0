Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B104A527EE6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 09:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbiEPHx4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 03:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiEPHxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 03:53:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714D227CE6
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 00:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=l/03mwnhAR+BDJ+VXcmFznp/o59n1ox5tWpbwkwwXg8=;
        t=1652687634; x=1653897234; b=dA4/QuOSfAXWmPYtCwhm0TR8tuB7ErOS1hNSca+cOYAZ06Z
        CSa5TzoIDV6ZDEcqsNEs3PNmlYSaazkMpmG4Ye32+DorecBbqWruoME1VOf+2dFMsFTUWHPCxydel
        OPW6hRbZe2w5XQMh44oCn5TMfYv2pRqhWwjdng3x0EfIQBfP/uAJQsnGJ+b/ieFD6C5VV3A+1f7PA
        2GHuEN037kKSxMY6zppEyVi0sBHOAJpg8sYgKLYjDcx8eg91ZJUMyf7CzJuLhiUJxoZjKncUcgqVN
        3k1VW7LtaBwQbpKulvUpHyC10ZSjBqwZsy41gg7+WcGQiz35ZnN/zGFP4OYci3IA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nqVY6-00DHls-4F;
        Mon, 16 May 2022 09:53:50 +0200
Message-ID: <ed2d6619d4f5b47582ba5edd0751eb16c18b5747.camel@sipsolutions.net>
Subject: Re: [PATCH v4] cfg80211: additional processing in
 NL80211_CMD_SET_BEACON
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, kernel test robot <lkp@intel.com>
Date:   Mon, 16 May 2022 09:53:49 +0200
In-Reply-To: <20220509225237.15955-1-quic_alokad@quicinc.com>
References: <20220509225237.15955-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-05-09 at 15:52 -0700, Aloka Dixit wrote:
> FILS discovery and unsolicited broadcast probe response transmissions
> are configured as part of NL80211_CMD_START_AP, however both stop
> after userspace uses the NL80211_CMD_SET_BEACON command as these
> attributes are not processed as part of this command.
>=20
> - Add the missing implementation in nl80211 and mac80211.
> - Modify the local variable in nl80211_set_beacon() and input parameter
> to rdev_change_beacon() from type struct cfg80211_beacon_data to
> type struct cfg80211_ap_settings to support the new processing.
> - Modify ieee80211_change_beacon() to reflect the new input parameter typ=
e.
> - Modify driver specific functions pointed by change_beacon to
> reflect the new input parameter type.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> ---
> v4:
> - Modifications to all driver specific function pointers.

That's fine.

> - Also included all files in a single patch instead of splitting as per
> the modules because otherwise compilation fails with changes in only
> net/wireless and include/net directories.
>=20

That I prefer not. Please send the mac80211 (and/or driver) changes
separately (make sure you edit the commit logs appropriately), with the
first cfg80211 change only containing the API updates across the rest of
the tree.

johannes
