Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A464F6E675A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjDROnv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjDROnt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 10:43:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D314479
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zgsQTXRwQZZl6pn/o91z4oDhbS6AdTHiGnBjka4kxE8=;
        t=1681829017; x=1683038617; b=XPZKTMDR0uIZvgb08oKcc5CdoKqTjeOtI9XQLeYzkrxgLZp
        /NkI+gqOVNVrKwrutM140QxMYBP2UtFF7UzMOamz71Z8sxIwcapZ/Sdo+8N+igrKmP68zTno9SkxN
        K5ZdMIoWZoD9mMSkSr/Dmb3Z2Fv3fQcyZjNGXhscxFiqrYfGzGu61eRxGuOgq/5pNrfyhxM9tGrB/
        ZMLXiyIUasKR00Ol4pYMP6TGTTw09J5wdZFvifQvwA2hCO/s2TG5qb3LnoyZVH+qvDV0o+vc+50rf
        5h63RuhA9W0bEX0Fr24CBNWwl4CS6lwsVifmpCyyOyMT1YBGfQIG/iYqwywGtDZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pomYB-001fVt-0J;
        Tue, 18 Apr 2023 16:43:19 +0200
Message-ID: <9619692082caef649e236eb154129e922c46b547.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning
 write backtrace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kees Cook <keescook@chromium.org>
Date:   Tue, 18 Apr 2023 16:43:18 +0200
In-Reply-To: <20230418132546.45297-1-hdegoede@redhat.com>
References: <20230418132546.45297-1-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Tue, 2023-04-18 at 15:25 +0200, Hans de Goede wrote:
> A received TKIP key may be up to 32 bytes because it may contain
> MIC rx/tx keys too. These are not used by iwl and copying these
> over overflows the iwl_keyinfo.key field.

Thanks for doing (and more importantly testing) this :)

> -		memcpy(sta_cmd.key.key, keyconf->key, keyconf->keylen);
> +		/* keyconf may contain MIC rx/tx keys which iwl does not use */
> +		to_copy =3D min_t(size_t, sizeof(sta_cmd.key.key), keyconf->keylen);
> +		memcpy(sta_cmd.key.key, keyconf->key, to_copy);
>=20

I'd kind of argue that just hardcoding 16 is fine here, keylen _looks_
variable so the compiler can't optimize it away, but in reality keylen
always must be 32 and sizeof() must be always 16 :)

But it also really doesn't matter.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>


Should we Cc stable on this?

johannes
