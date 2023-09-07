Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89160797AEE
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241895AbjIGR6F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 13:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343535AbjIGR6C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 13:58:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768311FF2
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=MUCMVkiYEltn2V3XJSxamUscp6Xa1h7qZiy3/996y80=;
        t=1694109456; x=1695319056; b=mtyQBKecZvqWbJF0ORqnDJqCpXvFUU0o1x+RlHj5u7U8IlI
        Q99yWlyUzGl+zKRTv/G4ZbcebUqTOYeaiFvxjvQxYGUXQBtyYOupIwEIWJ8hgW+yVGGhp5OQU73ww
        mL3fF3hLSxm9H0a4RAcgs/MPM+X9JkYi/WdaFUwxn2hakfGHy9jwEvepbBeQ5Nkcb/rO/Fv1ZPlqV
        l1HjVOWVQeoPKkeb9/i12U7AFqafA1VpPqea/FAT8H3Yc4upzr8thvwxMPR6wpGdmxMgLHFPdiBHS
        xRB7FeK1Fy1Z6jerPVs3udgJesn9jLTKrsVlCLXfYt+FkYmXONAOXM1SQQukE1Tw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qeJFw-0025Ka-05;
        Thu, 07 Sep 2023 19:57:28 +0200
Message-ID: <fc3eadf9f8f9e88ed2f1632253646ac1245e9c64.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: wilc1000: Added back-off algorithm to balance
 tx queue packets.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Prasurjya.Rohansaikia@microchip.com, linux-wireless@vger.kernel.org
Cc:     Ajay.Kathat@microchip.com, claudiu.beznea@microchip.com
Date:   Thu, 07 Sep 2023 19:57:26 +0200
In-Reply-To: <20230907170851.178834-1-prasurjya.rohansaikia@microchip.com>
References: <20230907170851.178834-1-prasurjya.rohansaikia@microchip.com>
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

On Thu, 2023-09-07 at 17:08 +0000, Prasurjya.Rohansaikia@microchip.com
wrote:
> From: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
>=20
> Added an algorithm to backoff the Tx Task when low memory scenario is
> triggered at firmware. During high data transfer from host, the firmware
> runs out of VMM memory, which is used to hold the frames from the host.
> So added flow control to delay the transmit from host side when there is
> not enough space to accomodate frames in firmware side.
>=20

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes#commit_messages

   Please write commit messages, like mentioned for the subject above,
   in imperative voice.=20

and that says:

   Subject lines, like commit messages (see below) should be written in
   imperative voice (=E2=80=9Cfix foo and optimize bar=E2=80=9D), not in an=
y other way such
   as past tense (=E2=80=9Cfixed foo and optimized bar=E2=80=9D).=20

johannes
