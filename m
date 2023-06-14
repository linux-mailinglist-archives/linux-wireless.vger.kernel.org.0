Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A0272F7F5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 10:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbjFNIgf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 04:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjFNIge (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 04:36:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7525411F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 01:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5X3DbXVamotUiJDEAUjOGrU/er263n0Rr6CZBj+gJDw=;
        t=1686731793; x=1687941393; b=MdTC7ujME6+qcHl1evUdzEO6f/vkcz6l/CJN3rzuYhw7Fdc
        /V/I1t/doJyZZN70DVpnwGuP4TIsX9TsmFeLSMB8a6l8ZbyECsLbHdQrpvWLNUSOSAEZmlMdalG/j
        zg3ccWj69L8JqfyIN5XT7Lmf7w3Bk4ANPzd0Lze9WcBNyaBmay+hAkyMwv0H17JYE80kAQ89RczzP
        P+lWnHSSsFypuYqAsRYM8Phx3OoN/Y4i1nRy6625PkJqFSMwuGmd6KmzKRfSXPnPB/w7vX+NB+zIk
        gEp//Wd6lZ7+mG7lvISUljwhVu8D5gSwx8OtrpaAisrNMYFkW2AhTHRvs6cIHg5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9LzT-0060rb-05;
        Wed, 14 Jun 2023 10:36:31 +0200
Message-ID: <b8e9d95705bbf9f9c248a156aa581053720b5aa3.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] wifi: mac80211: Fix tkip encrypted packet
 transmission path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aaradhana Sahu <quic_aarasahu@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Date:   Wed, 14 Jun 2023 10:36:29 +0200
In-Reply-To: <20230608070754.7161-2-quic_aarasahu@quicinc.com>
References: <20230608070754.7161-1-quic_aarasahu@quicinc.com>
         <20230608070754.7161-2-quic_aarasahu@quicinc.com>
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

On Thu, 2023-06-08 at 12:37 +0530, Aaradhana Sahu wrote:
> From: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
>=20
> Currently, TKIP encrypted packets are transmitting through fast path
> and fast_tx, fast_rx is not assigned in case of TKIP cipher so
> packet is dropped during ping.
>=20
> Fix this issue by sending TKIP encrypted packets through normal path

Not sure I understand this. How is fast_rx related, we're talking about
the TX path?

Also, how is this even a correct patch, since you submitted a series of
three patches, and
 (a) it's probably broken for ath11k until all three patches are in
     place
 (b) what about other drivers

johannes

