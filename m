Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B63E38984E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 23:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhESVCF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 17:02:05 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:48332 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhESVCF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 17:02:05 -0400
Date:   Wed, 19 May 2021 21:00:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1621458043;
        bh=+qSr2mI0QAcGavTUmtHCzyd66GD3fhdGxzW+vdx+1gg=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=ad3oaj3cPOB2EmUAArFPtJOt5x1anVhteIInj07m3Z9jUTBLkI214jeqhXfBqFLEN
         wHGg5hZNGWZrxfX+lU8Grn7boAxd9z+E60982/zXhmHZIYV4Y1hBwwDWF2dLleJwn+
         +JUKCqbuPY/dl259uXKJncBNW0OmJ7J2rRfNpDVo=
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Reply-To: rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Subject: Re: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
Message-ID: <ZJknGMd-LYMAOQNAoIsR9G59_Wlt9uYUPzzJ_v2p3W8kCQ_gIQ_ymF09TV83SN0h5Md0tyzlpIxTjCMkK88gXOkSI5UA_knH6RGUd4ITHrA=@protonmail.com>
In-Reply-To: <Qg7Ae-IznoeEC_X2m_4XXKRlM-yT3O7dzdbZ0egHTsdEaA0uILKZ0uBymFMrN7aI38rz-ZTKSxTDUAU4tKJPIntXELdx9Rd0MIU5sSG_VCI=@protonmail.com>
References: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com> <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net> <1jmF9EMZn2ywrHSGrNCzOUSAzllw9ox-Da2zfbSTnTULlX8Ha8F211TfKuxITBBtkfxiU_R0w7zUeFLdtDj4ejp6qPnCIhFj2U-rsCVNlMg=@protonmail.com> <Qg7Ae-IznoeEC_X2m_4XXKRlM-yT3O7dzdbZ0egHTsdEaA0uILKZ0uBymFMrN7aI38rz-ZTKSxTDUAU4tKJPIntXELdx9Rd0MIU5sSG_VCI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Monday, May 10, 2021 4:49 PM, rtl8821cerfe2 <rtl8821cerfe2@protonmail.co=
m> wrote:

&gt; On Monday, May 10, 2021 3:06 PM, rtl8821cerfe2 rtl8821cerfe2@protonmai=
l.com wrote:
&gt;
&gt; &gt; On Monday, May 10, 2021 4:16 AM, Larry Finger Larry.Finger@lwfing=
er.net wrote:
&gt; &gt;
&gt; &gt; &gt; The only splat that shows in either attachment is due to you=
 not installing the
&gt; &gt; &gt; regulatory database that sets the channels etc. for your dom=
ain. I do not know
&gt; &gt; &gt; what it is called for your distro - it is wireless-regdb on =
mine. It is unlikely
&gt; &gt; &gt; that this is the cause of your problem, but who knows?
&gt; &gt; &gt; Larry
&gt; &gt;
&gt; &gt; I installed the wireless-regdb package. The error message about
&gt; &gt; regulatory.db went away, but the system still froze.
&gt; &gt; I'll try the rtw_core parameter disable_lps_deep=3D1 now.
&gt;
&gt; disable_lps_deep=3D1 did not help.

The patch set called "rtw88: add scan notify to firmware and refine fw_feat=
ure check" may have fixed this problem. I've been running commit 6ccdad5a58=
e18eac6b1335f05f94bf2b36146e00 from lwfinger/rtw88 for 3 days now with no f=
reeze. It was impossible to go more than a few hours without a freeze befor=
e these patches.
