Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CCE724444
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 15:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbjFFNWr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbjFFNWj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 09:22:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D4A90
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sOxgyQeGcmLVIMfHi0677J6JW5hqS/gSgBY0NJqDUJU=;
        t=1686057756; x=1687267356; b=nV8VX+VjKs5VD7EJb7ReMN0XFF4rj30w51cx0VCdoSDdWIm
        9wKyMeikLdhRhujScswlt22QpyYZ18Uj4N+n+qCluBG5/s1fmp5AaHsH5e9ONm5IMaFkfV2FJRk/9
        BnfgNXWmp7e549vxRKOrTCsp47UaS3I0elcRpuXtR4jA/78pMgrqm6R3NENYVTwssEXhN/HBG79BU
        XW5bFu8uXyMb/fMzopBxt18vjwjqlv/UjPd3SeeGaiOAVU+7Tb9CSiExJlpqfELQuZAh11dpLuVX3
        IrPZVoY1Sh4Obt2Zplc5KEeFSV8+DzapBASpV7eEM1tu0yh3SR60fto1tqVpBfRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6Wdt-00FaFZ-1e;
        Tue, 06 Jun 2023 15:22:33 +0200
Message-ID: <0eb3fa52d11dc19e4d6eea2370d58592a4f018ee.camel@sipsolutions.net>
Subject: Re: [PATCH 13/16] wifi: mac80211: remove typecast in a call to
 ieee80211_config_bw()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Nicolas Escande <nico.escande@gmail.com>,
        gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Date:   Tue, 06 Jun 2023 15:22:32 +0200
In-Reply-To: <CT5LHVPA2Z4A.2SI6YNBBYRGD9@syracuse>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
         <20230604120651.1b01fef7c81f.Ib6492fe29fe31807b2fe31a84734b55d74b5c314@changeid>
         <CT5LHVPA2Z4A.2SI6YNBBYRGD9@syracuse>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
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

On Tue, 2023-06-06 at 15:18 +0200, Nicolas Escande wrote:
>=20
> Did I miss something or there's no code in this one but just copyright up=
dates ?
>=20

Yeah ... I already dropped the patch. Apparently Gregory missed, when
transferring from our tree to upstream, that these changes had already
been rolled up or done elsewhere.

johannes
