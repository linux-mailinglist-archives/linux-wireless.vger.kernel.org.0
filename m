Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C1D5A4F82
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 16:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiH2Op1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiH2Op0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 10:45:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA2961DB2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HaaW/DEBVscRrbh8z+rmUX7MK3Ypiu9xK8xiE1M1CWM=;
        t=1661784325; x=1662993925; b=Gm02fL1h02ZLrRGiutI5Vmd1ILGugOe63vTgqLWCz+LeAZP
        yA0J9RMdFekgtkmVsJhlPgEhEJUXZFl2ocvbxOy9sN0XGWXaJWdt+49F+rqxP8mUtL60olRgc2dCO
        QpZctGrtyv5pH83bUS7J55c11CwfqMgo4qtBJ8jV+HndaOmQFrFPK3mefXc6rkkBnIOaC4f0bY0Gn
        8gwK84FhpXEHN3XywqztBoIfMQcej2c70flMgZIVWBtm4Y11yJ+eOCvRzyC8A0ibcDB4rNEsEudbI
        y4GPo85AXMcc/K+IAHaDL08AJHRdi9C7pYeJQ/V+PiOCnAGjmZS4cbUCRTQuhnyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oSg0v-002pbz-35;
        Mon, 29 Aug 2022 16:45:22 +0200
Message-ID: <5175b7f95442eff1f8e899feee3d3aeb330fb61e.camel@sipsolutions.net>
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Date:   Mon, 29 Aug 2022 16:45:20 +0200
In-Reply-To: <20220829144147.484787-1-jelonek.jonas@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
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

On Mon, 2022-08-29 at 16:41 +0200, Jonas Jelonek wrote:
> Transmit power control (TPC) per packet hence per station can be used to
> manage interference and increase overall spatial reuse and therefore
> increases sum throughput in WiFi networks with multiple APs and STAs.
> Although several of today's wifi chips, e.g., from QCA and from Mediatek
> support fine-grained TPC per packet, the Linux mac80211 layer does not
> provide support this annotation nor control yet.
>=20
> This series proposes several changes to introduce TPC support in
> mac80211, in particular to annotate tx-power per packet/per mrr stage in
> the Tx control path.
> The patches include new nembers in the Tx control path structs, a
> modified tx-power level support annotation, hardware flags and an
> utility function for the convenient use of struct ieee80211_rate_status
> (introduced by 44fa75f207d8a106bc75e6230db61e961fdbf8a8) for tx-power
> status report in drivers.
>=20
> Compile-Tested: current wireless-next tree with all flags on
> Tested-on PCEngines APU with ath9k WiFi device on OpenWrt Linux
>         Kernel 5.10.137
>=20

That seems just a little old? Not sure I'd trust that given the major
changes in the tree recently?

johannes
