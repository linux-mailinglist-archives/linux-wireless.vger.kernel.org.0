Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF501783A58
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 09:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjHVHJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjHVHJ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 03:09:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEB71AE
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XtXE7Da9dgpKULyjJKYWpoJdAyic1sCvV2g0LPoERhw=;
        t=1692688163; x=1693897763; b=VQH0lQDtuxFBI/p+KNKV0cxvYmTtiwoSx6bY5AvbhW/c96d
        Y9pSSTvk0HqnBNDemBlbo166utf9bzAkMQKSmhZMsyX7hsUmGLBKvaavEL8LYk8Aw8HxFSrgezAdc
        TMwzFc0VrOYXKRi9AXj0/1CNnYZuhdU5dnZ9rzOxHLI3y6X0QA24BnZs6e7Ug7PcbkoExKE4OZbi8
        bTrWO1wmU6rL1XeUNNY4acIDbaJ9eLWIBuh4MRelQioEXnr9FxeseknUHRApb28GS2zZSYTY84cxC
        d/rLorA+jQYaRjsxYFVB9/WKycypSaWrzakExlIW5uY0hvUqCAanMyx6qIudaSzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qYLVw-004oCZ-18;
        Tue, 22 Aug 2023 09:09:20 +0200
Message-ID: <809d495a0f95790096bda9d7fd392998c4086152.camel@sipsolutions.net>
Subject: Re: [PATCH] Revert "mac80211: add parse regulatory info in 6 GHz
 operation information"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Date:   Tue, 22 Aug 2023 09:09:19 +0200
In-Reply-To: <ee8b37a1-0a5e-cc2f-8b88-a1263ee1b761@quicinc.com>
References: <20230821105903.7482379cde47.Ib72645d02fadc24b520db118abd82e861c87316e@changeid>
         <f28ee65621bd52ad59cae891e81431ef83eeaf2e.camel@sipsolutions.net>
         <9ce54e8e-556b-976c-06d9-145b747705db@quicinc.com>
         <714fd7374225db9e8d8225197931c5183f12e534.camel@sipsolutions.net>
         <6adeb7be-9c7a-c122-71be-cc0143115fe6@quicinc.com>
         <0f34540e71e7ba63a3d38e85aefec74350384a33.camel@sipsolutions.net>
         <ee8b37a1-0a5e-cc2f-8b88-a1263ee1b761@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-08-22 at 14:17 +0800, Wen Gong wrote:
> >=20
> > Anyway it would seem better for a utility function to have clearer
> > defined output, I think?
> >=20
> > johannes
>=20
> Do you mean move the logic of set bss_conf->power_type to another new=20
> function from
>=20
> ieee80211_chandef_he_6ghz_oper()?
>=20

No, not really. But we could have a pointer to the bss_conf or even the
particular value, as an obvious output from the function.

johannes
