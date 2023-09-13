Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2532B79E4AC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 12:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbjIMKRq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbjIMKRp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 06:17:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89011727
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jN+sZKcnCw2xCWfqCVgbNlMkLsTh+etQVh8RXFinems=;
        t=1694600261; x=1695809861; b=jx4WJndDKattdtRhx0L/jorW7/tJoG23Dv25l62DdJex7qx
        gexGD8xpcMnq2BSy6tA7NCHkZa/UDsdHUw4DWoDPuMXQi4PXzurD/OzXO0YEuWIItbJY0+I6ptQtO
        PGxrSJCdOxj6o58M/SGhpngyl1K3z8AWA5s5sKHYIRZugYnysX4BURWQyd/zY37f/w22aBntP2GtZ
        rYTxSjhr2fcIJaaq/UTPZE3bW2R4pfSKcsX9EMcCtQCy8cF2f+yfAAOuyerPsuanmtsvUrFcT6D9e
        b6b90nz9divAY1M1W9VIhxOTMs5EFMuxs27GmxV/DGFbQrX8gqZK8nVxZ9Pz3WTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgMwF-00EmRJ-12;
        Wed, 13 Sep 2023 12:17:39 +0200
Message-ID: <365caa2a20678c1c1c08c947a2141b40320553c6.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] wifi: cfg80211: export DFS CAC time and usable
 state helper functions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Wed, 13 Sep 2023 12:17:38 +0200
In-Reply-To: <511f23be-7b7b-42d9-9c3e-25edfa5d7323@quicinc.com>
References: <20230912051857.2284-1-quic_adisi@quicinc.com>
         <20230912051857.2284-2-quic_adisi@quicinc.com>
         <f436ea028da7b016241f307348286be6cfe7df65.camel@sipsolutions.net>
         <511f23be-7b7b-42d9-9c3e-25edfa5d7323@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-09-13 at 15:46 +0530, Aditya Kumar Singh wrote:
> On 9/13/23 14:58, Johannes Berg wrote:
> > On Tue, 2023-09-12 at 10:48 +0530, Aditya Kumar Singh wrote:
> > > cfg80211 has cfg80211_chandef_dfs_usable() function to know whether
> > > at least one channel in the chandef is in usable state or not. Also,
> > > cfg80211_chandef_dfs_cac_time() function is there which tells the CAC
> > > time required for the given chandef.
> > >=20
> >=20
> > Should we really export the time function just for a debug messages?
> > That seems like a waste of space?
> >=20
> Yes absolutely. But actually as a follow up of this patch, we have=20
> Background DFS patch in pipeline which requires us to send the CAC time=
=20
> to firmware. So its actually needed there. And may be once we do this,=
=20
> other drivers also may start using this?

OK, fair enough :)

johannes
