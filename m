Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398DF72FA1C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjFNKIG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243789AbjFNKHm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 06:07:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218B1FD6
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bv33olME/P1SJGBsr2FZLMiFk6Mc9y73BiLXf0hBm88=;
        t=1686737251; x=1687946851; b=mndXLMPpAt7iTWr+nfVWV8E52tuz1b0b1MND7Qn5sXPfdtD
        cEBlK79nN7TpJIZJROJzD7wGXknAt6HldQlitUorJ7UTuzLnAJguWbPT2J5+RAdTFHfL08lcqYZ5b
        cYxQuebUKvg8zckOnTf4sx9Gsa4FXVlp/cWnE+hQ1v6AOJy9JZto/DQbYWU6eXlgWYWn4fxUTx1ek
        CAFgTs/pONTtseqVtRt0fZmTTo1kT8bAW2fbQMrdQIKGcbRAZpZ64df2EXrh3EZ/oxB6N+Xbw9DB4
        FEbyXNdAPF4MapjwQKzo5q88PatQane20TEp2SBJpYXP+O365n+fWMuyTT1l7R4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9NPV-0063tW-2r;
        Wed, 14 Jun 2023 12:07:29 +0200
Message-ID: <416fc1eba88e13c245fac4499ee0af2efbd5485a.camel@sipsolutions.net>
Subject: Re: [PATCH 08/15] wifi: iwlwifi: mvm: Add NULL check before
 dereferencing the pointer
From:   Johannes Berg <johannes@sipsolutions.net>
To:     gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Date:   Wed, 14 Jun 2023 12:07:28 +0200
In-Reply-To: <20230612184434.cf7a5ce82fb0.Id3c05d13eeee6638f0930f750e93fb928d5c9dee@changeid>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
         <20230612184434.cf7a5ce82fb0.Id3c05d13eeee6638f0930f750e93fb928d5c9dee@changeid>
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
> From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>=20
> The p2p, bss and ap vif pointers are assigned based on the mode.
> All pointers will not have valid value at same time and can be
> NULL, based on configured mode. This can lead to NULL pointer
> access.

This is not true.

>  	/* enable PM on bss if bss stand alone */
> -	if (vifs->bss_active && !vifs->p2p_active && !vifs->ap_active) {
> +	if (bss_mvmvif && vifs->bss_active && !vifs->p2p_active &&
> +	    !vifs->ap_active) {
>=20

The pointers can only be NULL iff *_active is false, however, it may be
false even if the pointer is non-NULL, so it's not exactly the same.

Probably a static checker thing that didn't understand it?

johannes
