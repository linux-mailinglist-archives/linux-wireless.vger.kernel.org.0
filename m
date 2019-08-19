Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500FD94ACA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfHSQse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 12:48:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36962 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726553AbfHSQse (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 12:48:34 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzkpb-0007zT-RE; Mon, 19 Aug 2019 19:48:32 +0300
Message-ID: <eb827646a12d858c8d8caeebd92e1dd2703caa65.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 19:48:30 +0300
In-Reply-To: <87mug5kxwv.fsf@codeaurora.org>
References: <20190819143507.6989-1-luca@coelho.fi>
         <20190819143507.6989-10-luca@coelho.fi> <87mug5kxwv.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 09/22] iwlwifi: add ldbg config cmd debug print
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-08-19 at 17:55 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> > 
> > add support to print ldbg command in mvm and xvt mode
> > 
> > type=feature
> > ticket=none
> > 
> > Change-Id: Ic5a963db7785f616e49af7f7e7ee0cd86408e07d
> > Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> > Reviewed-on: https://git-amr-3.devtools.intel.com/gerrit/223367
> > automatic-review: ec ger unix iil jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
> > Tested-by: ec ger unix iil jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
> > Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
> 
> This needs some cleanup :) And also Luca's s-o-b.

Argh, that's what happens when doing it manually... :(

--
Luca.

