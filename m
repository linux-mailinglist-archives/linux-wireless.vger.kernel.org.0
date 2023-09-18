Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5362E7A4380
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbjIRHw2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbjIRHwI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 03:52:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786AB30C4
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 00:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ec02TSjdTHuIcXUnSvMKpVMkNA8DWplDTKJsNzmmkhs=;
        t=1695023316; x=1696232916; b=xovCkaZ5eVjuLEzhQcqwfsvND1utKgpDXLXWoMb9Pkv4zpp
        gJRTcOD7EFNbjTGqU/D5bJPYxZBgxtNJtOmLhh/hnvrQdZ8BXKGkkfx/Mn+sdeck59UM4QwlA0FOn
        6xgnTV9eeaT9CYUPsyHIxRMmd/zqmXj29usA4R5vQAUyNoC7BvXHR1q8RJzuHvx+4Gv97Y+NUncRP
        CfetjcGBxHV0WfQrYtnnJFKPXbrf4F+dwFRAYGEOSv+SaEp/aIS31f7aaleknHS1QF5yqCOJZNG4O
        KRAjQkx7VIVmVGI73Qf/H6Hb8a0lOwgT6BhBikNL9S8NvrhXnjcOvMQSPDW4u8HQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qi8zZ-006waz-1W;
        Mon, 18 Sep 2023 09:48:25 +0200
Message-ID: <09e4413a307a8614534af4eb08e007d897114d23.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/1] cfg80211: Allow AP/P2PGO to indicate port
 authorization to peer STA/P2PClient
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Date:   Mon, 18 Sep 2023 09:48:24 +0200
In-Reply-To: <75476a44-e85a-4fba-ae02-c15f1f051bdd@quicinc.com>
References: <d19fc849488e63cf367029b614289c324f531ae8.1694751711.git.vinayak.yadawad@broadcom.com>
         <75476a44-e85a-4fba-ae02-c15f1f051bdd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-09-15 at 12:11 -0700, Jeff Johnson wrote:
> On 9/14/2023 10:17 PM, Vinayak Yadawad wrote:
> > In 4way handshake offload, cfg80211_port_authorized enables driver
> > to indicate successful 4way handshake to cfg80211 layer. Currently
> > this path of port authorization is restricted to interface type
> > NL80211_IFTYPE_STATION and NL80211_IFTYPE_P2P_CLIENT. This patch
> > extends the support for NL80211_IFTYPE_AP and NL80211_IFTYPE_P2P_GO
> > interfaces to authorize peer STA/P2P_CLIENT, whenever authentication
> > is offloaded on the AP/P2P_GO interface.
> >=20
> > Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
> > ---
>=20
> v1->v2 change log is missing
> can you provide that as a separate message

Or just fix it with v3, this doesn't apply ...

Also please indent the documentation per what you see there (tab).

johannes
