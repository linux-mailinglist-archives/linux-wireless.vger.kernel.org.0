Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0065C4AA2B2
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 23:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbiBDWDE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 17:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245107AbiBDWDD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 17:03:03 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC93C061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 14:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=FKolgv4jPk6TWN4sBBto49H8T5WS8B5y1sw+LscBdHE=; t=1644012181; x=1645221781; 
        b=WN6+WrLULYiFwDofGoe4wPNUsdLnG7Cy+kQkn2+2Lo4dwlRrNXowlcnwqog86g4iwjuwrqzSGN0
        DgcLfSlVjo4P4ooqc4X/GALB4/8Tr7ZNLPZQGOJo3qbHkGbzZooMWxZItRSHY7gsKOE/VQW656bQI
        jEyPyf4nl+ELM/B0Tjq8uddFdBkHkgtMLseNG3eGpHA6dEu2/75S9iiz67II5z2WJTPYyDHdqJWz1
        euCihSxNIW+7j9cRmbyKdsyRn4gXLTo+qPNl1CzQ6ElwConWRCEtUFPQwuXFa6Pgnt1zUELHIAjhT
        1EzTWUKIE84tYikf4WTWO5YYCuzwijMnH1Ng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6fT-00EeJL-Cn;
        Fri, 04 Feb 2022 23:02:59 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>,
        Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 00/19] initial EHT support
Date:   Fri,  4 Feb 2022 23:02:36 +0100
Message-Id: <20220204220255.448224-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

So I tried to combine the work we already had internally with
the series that veeru posted at
https://lore.kernel.org/r/1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com

Hopefully I got all the bits right - but I think even if not
we have enough time to fix it before EHT ships, so this might
anyway be a good step to align between everyone.

I did stick to 8 NSS for now, but if the spec becomes clearer
either way we can obviously easily change.

johannes


