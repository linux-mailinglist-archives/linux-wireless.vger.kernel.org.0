Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F4D671AFC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 12:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjARLot (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 06:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjARLn7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 06:43:59 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3D2656E3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 03:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=i+jNHfWQzgTfi+BnkS8RcYvK0RyjD+V5VmuI4yXlum0=;
        t=1674039848; x=1675249448; b=Y1h+RcZL3/M2jH17r9ifvtXHnpN9toebbCEDdWkw3GuONy2
        Rr+AAiMbzhsMXGAOACl5gH4GJwcPryupwMd+13HBcMaSdJdm9UqgqBKzSlF8FJCEHU2qqHTwK9MW4
        6lhOKuAfT9JDJ7/9W6+8gh43hbXQIJNJr/D9bnDrczEo0sVVqz0xh8+xWjI0mEKkZwOJV/xDwcBGg
        ivmywqlh+v9Zt4yIP9OF1JqA/9TOF74uFh1yliwEtBtMYQo3zXYKOwUSpYxzefB5Z1oFRlgYF7ala
        CU293c8pDXtU5PptWRCy0ZZPgpAs72/Nf+RhqH8+VdSHMeu2AoigAfHFhQ4D+v4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pI6Dx-005ZZs-2n;
        Wed, 18 Jan 2023 12:03:21 +0100
Message-ID: <0ed850ac7d13fc5d40545aff1d59d710374bfcf4.camel@sipsolutions.net>
Subject: Re: [PATCH 6/7] cfg80211: rework nl80211_parse_chandef for 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 12:03:21 +0100
In-Reply-To: <20220704102341.5692-7-quic_adisi@quicinc.com>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
         <20220704102341.5692-7-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-07-04 at 15:53 +0530, Aditya Kumar Singh wrote:
>=20
> +	/* For APs, 6 GHz power mode is taken from the user configured
> +	 * value. However, for clients, power mode is also dependent
> +	 * upon the APs power mode to which this client has associated.
> +	 * Hence for client, need to take power mode of asscoiated AP,


typo - associated

But anyway, were you going to resubmit this with comments from the first
patches addressed?

Honestly I'd also like to see a bit more discussion (in the cover letter
I guess) about the solution with "multiple channel spaces" and all that.
And ideally about alternatives considered - why not for example keep a
single space with flags indicating support for the power mode, etc.

johannes
