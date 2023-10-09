Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799DA7BE553
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 17:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376985AbjJIPsn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 11:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376789AbjJIPsm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 11:48:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BE699
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qvmMxpidy+ngOcPeaz4a6tEod5cfiIoDKN82PomQRGg=;
        t=1696866520; x=1698076120; b=PuTKrrhS78j+o6375uRKSwhBbzDsJK8AuP0vT0I6sVGekm2
        nMtzpftdqN2faWkIhMz7gYVHmARdETe2h9IfKDX3vsRYlH8oWB9uubxnHQxL+r505jIqb50oct4uy
        9Qihtr3AhzR+QZ7oNopLmbXLJ6T0najsGH12P8JGOVTr4OEjQREnb75FNtBqSzk8DfBGfHhJ4Z+ya
        lmWM1RHEXF7dZ8pkuOgJV5uAIemlIGYaOAXfx6cpRXa7qLeQxmVrx+0+XuwUcLzQTKuvoG6paEAL4
        EkUUAv06i68xdLRwoa2Rr5XYPhvG8e4E+aS4luXMe9ZObyJuNyC47XmlfEqrKOsw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qpsUn-0000000Fmsz-0B9v;
        Mon, 09 Oct 2023 17:48:37 +0200
Message-ID: <e65522be907a2bb3094a209ec2ebe87d6302351a.camel@sipsolutions.net>
Subject: Re: [PATCH 5/6] wifi: radiotap: add bandwidth definition of EHT
 U-SIG
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 09 Oct 2023 17:48:36 +0200
In-Reply-To: <20231006131327.16806-6-pkshih@realtek.com>
References: <20231006131327.16806-1-pkshih@realtek.com>
         <20231006131327.16806-6-pkshih@realtek.com>
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

On Fri, 2023-10-06 at 21:13 +0800, Ping-Ke Shih wrote:
> https://www.radiotap.org/fields/U-SIG.html defines bandwidth field but
> no enumerators there, so reference to the values defined by wireshark [1]=
.
>=20
> [1] https://github.com/wireshark/wireshark/blob/master/epan/dissectors/pa=
cket-ieee80211-radiotap.c#L2466
>=20

Well. The entries here should be coming from the spec, see Table 36-28
"U-SIG field of an EHT MU PPDU" in 802.11be (D3.0) (or 36-31, it's the
same since it's U-SIG-1 common part).

So maybe we should define them in ieee80211.h?

But at the very least I think the patch description (and perhaps
comments in the code) should reference that, rather than wireshark
sources :)

johannes

