Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD1562E27
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiGAI2Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 04:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbiGAI1m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 04:27:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB1072EC3
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 01:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4batUZgzi/pcET5q4/02wlKJneIu5oSn1bUtVFzA9Ok=;
        t=1656663972; x=1657873572; b=iuEmrXOHMgPsZuzoofXFSM64tIpzvF8sTiuJH2FqlTqvCog
        9qgoi6+ODVP2XYISeXtPo8pC0ts9PH/EcKHtx/vGdywLryAunJ3hrGmvUxc0Y8B2Iyvo/P/20w+2j
        StfIzLZWxhyIgxWldVw6I65j6EV/6QWNY0U2ako6TltDX9WjLs0cYLDTnBuNV+o4GJKFqRIMcK7HS
        SbkcTokN8SK4D7evpi3fxGRyJro3EwxQAiDEWb6pFCmZn9wTHxqfrX2tv6ADp0fgu84p0DCUv/C8r
        SlcahWnxi7iDSEKbhGLMhmIMsKPvIA1Q9C9bykb//VnF741EwJXozHKoqztM4Iig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o7Byc-003Ogp-Kq;
        Fri, 01 Jul 2022 10:26:10 +0200
Message-ID: <4dc3769bc1337baa588ec8393b4e2ee8cd8f41eb.camel@sipsolutions.net>
Subject: Re: [PATCH v6 0/3] Additional processing in NL80211_CMD_SET_BEACON
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 01 Jul 2022 10:26:09 +0200
In-Reply-To: <20220518203922.26417-1-quic_alokad@quicinc.com>
References: <20220518203922.26417-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
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

Hi Aloka,

I'm sorry, but the MLO work that ended up getting priority here has some
conflicts with this, and I'm not sure I'm comfortable rebasing this
myself, I also don't know how to test it.

Could you rebase this please?

Thanks,
johannes
