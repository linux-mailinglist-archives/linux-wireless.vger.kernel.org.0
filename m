Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA51B5F9B60
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiJJItt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 04:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiJJItl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 04:49:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B754115B
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8ay2ZLbBq/ugQxTsdqCHsyFv3bWfghNdYBbD4d+l310=;
        t=1665391777; x=1666601377; b=gk3n+HdrHJwftfIAadpnKMttfqVh9SIi7xZYZCoNs9craT9
        yhQDJhWLxnNXoSaR03wK54pgLjturn8U3nPJAOG44/BSQ50DQF3ef4e1CVBJvj1hECvm00cmrhvZq
        HWQib64T3OmojVAMuKw3mc5HPDn/igZ8ibWjICPZu0hPzzGW4/BeYlRzeeo+xg/dMAolS3vPSKK3n
        aHERjpIer6DZ65W/qCBAZ1hAuk/+tbxExNvYzuygqX9W1vcc63HGplcz+LzU83CQCGHN5csMG3QpI
        2wmp0lnxoVFa83+QXVpzTXYej78rWyxUnzLadHoluJek3kGfrz2Yk/wI+QCxxzPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ohoTe-002xiG-2Z;
        Mon, 10 Oct 2022 10:49:34 +0200
Message-ID: <a510188243f0080e470245ab95bd4976a5b0e923.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] wifi: mac80211: add internal handler for
 wake_tx_queue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Date:   Mon, 10 Oct 2022 10:49:34 +0200
In-Reply-To: <20221009163040.25637-1-alexander@wetzel-home.de>
References: <20221009163040.25637-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2022-10-09 at 18:30 +0200, Alexander Wetzel wrote:
>=20
> While there is obvious something wrong with ieee80211_build_preq_ies() fo=
r
> hwsim, that's unrelated to what we are doing here. (Multiple tests
> trigger the WARN_ON() in ieee80211_get_he_6ghz_capa().)
>=20

Yeah, something is strange there, I never saw that but I feel like I
should have?

I _think_ it might be fixed by

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commi=
t/?id=3Db650009fcb701ea99aa133bbe18dbfc5305ddf1a

johannes
