Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF095AE459
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 11:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiIFJg3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 05:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiIFJg1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 05:36:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1796C65655
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OwMpiQUXFqyozuzM2kQc6EZpGi0aoImyOXvtdY8QljA=;
        t=1662456986; x=1663666586; b=ivT1pXZw6O3WBewgNW19QfhcZjB9wX5gljXmCEdjNJ5AMNr
        DCT148H2gXqHECf8NPYrhdDAkG53QWNvymN83erYs1jtc9C9htDL6526wMcBpadkcCBhNnfeO310c
        0BlQSoTx2G/RV54xsfLXtEL39dR24xk+ZkoAcHoj0mBJhtyV7dO/VeUzOaBTUc4G0f76bdrIseZeh
        WR7EEGwMS2Tj7RT6yYEod0jqn5lSQR0Fm8B/HlIlfErhyKkj4i+XhYgxbzuM7gIusDicQMtoIQpe+
        sPDezu2uI8nlpMt+ykpehFZZUTbETlv3+PvVon6BCEwe1pxYD8Vbhh40xr67c3aA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVV0I-009MSM-0V;
        Tue, 06 Sep 2022 11:36:22 +0200
Message-ID: <33a46d12583b540a921f6ce96065c9a177bd044d.camel@sipsolutions.net>
Subject: Re: [PATCH v3 01/12] cfg80211: regulatory: extend regulatory
 support for S1G
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kieran Frewen <kieran.frewen@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        kernel test robot <lkp@intel.com>
Date:   Tue, 06 Sep 2022 11:36:20 +0200
In-Reply-To: <20220906044812.7609-2-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
         <20220906044812.7609-2-kieran.frewen@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Tue, 2022-09-06 at 16:48 +1200, Kieran Frewen wrote:
> Extend the S1G regulatory information to support all regulatory
> domains. An reg_s1g.h file is included containing structs with key
> regulatory class information. These structs were required to ensure
> the right combination of information was available to a series of
> functions which support the mapping between frequencies, bandwidths,
> and channels.
>=20

Hm. Isn't this type of thing something we'd usually want to keep in the
regulatory database to be able to update it? Who says JP will always
stick to their restrictive scheme, for example.

johannes
