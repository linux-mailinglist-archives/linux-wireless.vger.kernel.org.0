Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870446F6548
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 08:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjEDGwf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 02:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEDGwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 02:52:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C54830FB
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 23:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4A4G4qwEPKMlunWXWecKMmAoXT1IA0fweLSiZ+GVAJM=;
        t=1683183143; x=1684392743; b=CppX6Odt7mJ58ph9rEjlY2pjbcPahfLZUC5E+wAcUem/051
        rXrmY2jILGmBhTn+IYdRNJYSv/c9HeG29Qt5qzMOz/kMS/zg5lr3CQjXD6FSq6VsEWS2yTM5SNxHR
        Gh9sLWxzB427VYvPiu6v+CHrJ4dJNcfT5CXHStJ3WILFpLbGvLXnC81UMJomValluOObkARhEfug4
        KTqWsH8cczSXIIU1ofak9Re9DplZqeq1PvcdaAs71alRo67UVxn/hnrQ1lW9EskYMMh1ONk5Z9p6h
        tVWQFVIfvvZCXJb4sc3HRXbABBAandR0d0dkyDXLXlWcZSoCZKfcFBGx87gHzDqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1puSp7-00GpXU-2g;
        Thu, 04 May 2023 08:52:17 +0200
Message-ID: <d2e0469440d366c2323424ebfc1b634d669e1ed9.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Abort running CCA when stopping AP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michael-CY Lee <michael-cy.lee@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Thu, 04 May 2023 08:52:16 +0200
In-Reply-To: <20230504061049.21082-1-michael-cy.lee@mediatek.com>
References: <20230504061049.21082-1-michael-cy.lee@mediatek.com>
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

On Thu, 2023-05-04 at 14:10 +0800, Michael-CY Lee wrote:
> From: Michael Lee <michael-cy.lee@mediatek.com>
>=20
> Signed-off-by: Michael Lee <michael-cy.lee@mediatek.com>

A commit message would be nice. And maybe a fixes tag?

Also "CCA" is something else, not related to color change, not even sure
where the "A" came from?

johannes


