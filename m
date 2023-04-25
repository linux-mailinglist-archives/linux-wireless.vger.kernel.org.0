Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3986EE772
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 20:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjDYSTB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 14:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjDYSS7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 14:18:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49DE7D85
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OEm1h9Fvp/Tk3/rRCqLyzOHEG6dIAISOoeHlaFTz5ic=;
        t=1682446738; x=1683656338; b=OyyqKzPmqTqwgBr6h6q+4PQ2yydLUUMozVVQFeWrgKoUn+n
        H3YIuC31NWoL5rxA2hzFgVt0DXJKtkC+dIS6K13DmdqHWopHEmL3H9DzWEWim7/VUaw4JXLmYsjNc
        X3nnnVJPHmpUqCHaufRl6obLH/iqrdAbXDjgry1V/lfpL2CuFUWPcfXJhXpM6j0df3ZaHartCknwg
        vMhHG8Spyyv9SHnT14YL4JMOWMscJk1JJ7KeChuETQEAAWG7kFRx3pjOhIdkg50TxJmtEMhhfa++L
        xZGlksnpfzgCwtZH9jozbcoUrYI4OVKxQWPOviA6yQikq5of+MfOD8mXYB+62OQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1prNFg-008JGT-0Q;
        Tue, 25 Apr 2023 20:18:56 +0200
Message-ID: <a3ac7cf40706771977138a437560475b035efee4.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3] average: change non-init state and add check for
 added values
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Benjamin Beichler <benjamin.beichler@uni-rostock.de>, nbd@nbd.name,
        linux-wireless@vger.kernel.org
Date:   Tue, 25 Apr 2023 20:18:55 +0200
In-Reply-To: <20230424210430.390592-1-benjamin.beichler@uni-rostock.de>
References: <20230424210430.390592-1-benjamin.beichler@uni-rostock.de>
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

On Mon, 2023-04-24 at 21:04 +0000, Benjamin Beichler wrote:
> The uninitialized state 0 involves the danger of reaching that state in
> normal operation. Since the weight_rcp value needs to be bigger than one
> (otherwise no averaging takes place), the final shifting in add ensures,
> that the internal state never reach ULONG_MAX. Therefore use this value
> to signal, that the ewma has no initial value.
>=20
> The add function needs to check, that val is not to big, otherwise the ne=
w
> value can overflow the internal state, which results in unexpected output=
s.

This seems nice to me, FWIW.

> Move the compile time checks into a separate macro, as they are used
> multiple times and noise up the functions.

Why do we even have those multiple times? Should be enough to have them
once, since we always compile the static inline functions?

johannes
