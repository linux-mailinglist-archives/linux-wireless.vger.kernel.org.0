Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340DD778962
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjHKJDI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjHKJDH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:03:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23685E0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=30O0i+CKxrgVUoyVg9Uo788qQ6EUk0N1sFInGdbhQMQ=;
        t=1691744587; x=1692954187; b=o2ZUUVTI0rZWznU/6WKhIJd6r89APZC3Qq85+MAbyI768Wf
        uhvWVhigm84AVYUyZ08kmD8qxU6r2wZQtBgknD9ctmrReSJMuy7lGe5MGceGuB+GG1ugz5Vv+1qTz
        2eDtcCdfLrMidNHE6q1IOSZL6Bc6xa7vL91U4htu8VnqVv8PSFhgp0gR0G26zazgsvuPHh0nEoIv1
        DOzULP9QWpHSwoPpM9EQE6kCJ+ffPP+G3k8HPx7QSCzmUiNeR9Xannghmwj8wZL0sEphYROSN6yjo
        oks9BKCcqcfOKh4pC9xvN7u/u4YQ9BhAwE+dliA9WOeTNOt3ZCgeuoZeXKFy0/Rg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qUO2x-000o6U-1D;
        Fri, 11 Aug 2023 11:03:03 +0200
Message-ID: <f577425e2d4fd6141c29bcbfbea919565da9326d.camel@sipsolutions.net>
Subject: Re: [PATCH 61/76] wifi: nl80211: add EML/MLD capabilities to
 per-iftype capabilities
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org, quic_rkaliapp@quicinc.com
Date:   Fri, 11 Aug 2023 11:03:01 +0200
In-Reply-To: <d2f17799-6d90-9d72-a389-565163d723d2@quicinc.com>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
         <20220713114426.4dfc9ebd0461.Ice7b841051cfeb23da17bb2caa0e45191b34c4db@changeid>
         <d2f17799-6d90-9d72-a389-565163d723d2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-08-11 at 11:51 +0800, Wen Gong wrote:
> Now there are many nl80211_band such as NL80211_BAND_2GHZ/
> NL80211_BAND_5GHZ/NL80211_BAND_6GHZ... In the same interface, if some ban=
ds
> support EML, and other bands not support EML, then how to handler this
> case?

But ... these are MLD capabilities, not of the (associated) STA?

So not sure how that would make sense? What would you even _do_ with
that?

johannes
