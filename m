Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C37218E960
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2020 15:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCVO3y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Mar 2020 10:29:54 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:43799 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgCVO3x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Mar 2020 10:29:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584887393; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=uduuflPW6mRUBQt22S2/ahlaqSxY/AvKy1ZfHU/NiUs=; b=pST6Q+nIsjv2NTzvG1YE/YZoC8lFMGi2bdlsrccKd/9t5I013wQezwEeZERe7yLYZFGFaq85
 K18FB5E57h7n0Bj7hpO1zBj+GR34v7x8bpbubNcfXcnazzMaSoUG+iotGQGk/9pI4SHz8fFC
 FpWNtmLj6toejkFZ6WIaxNXeLCY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e777651.7f0d3816d618-smtp-out-n04;
 Sun, 22 Mar 2020 14:29:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D9DFFC432C2; Sun, 22 Mar 2020 14:29:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 428C8C433CB;
        Sun, 22 Mar 2020 14:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 428C8C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chi-hsien.lin@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 2/3] brcmfmac: make firmware eap_restrict a module parameter
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
        <1584604406-15452-3-git-send-email-wright.feng@cypress.com>
        <aa29c77c-cfe4-3d71-1860-f9bcb9e0282b@broadcom.com>
        <9683e5c3-5f68-5632-e1cf-c31e51379673@cypress.com>
Date:   Sun, 22 Mar 2020 16:29:31 +0200
In-Reply-To: <9683e5c3-5f68-5632-e1cf-c31e51379673@cypress.com> (Wright Feng's
        message of "Fri, 20 Mar 2020 16:06:11 +0800")
Message-ID: <871rpkcvjo.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> writes:

> Arend Van Spriel =E6=96=BC 3/19/2020 4:28 PM =E5=AF=AB=E9=81=93:
>> On 3/19/2020 8:53 AM, Wright Feng wrote:
>>> When eap_restrict is enabled, firmware will toss non-802.1x frames from
>>> tx/rx data path if station not yet authorized.
>>> Internal firmware eap_restrict is disabled by default. This patch makes
>>> it possible to enable firmware eap_restrict by specifying
>>> eap_restrict=3D1 as module parameter.
>>
>> What is the reason for not having this toss behavior as default?
>> Don't see much reason for having the module parameter.
>
> The eap_restrict feature in most of firmwares are disabled as default,
> and refer to our experience, using eap_restrict increases roam time
> for associations in some cases.

What are these these cases exactly?

> So what we do in this patch is not changing the default firmware
> behavior but still give users a way to enable eap_resrtict feature.

You should have mentioned this (ie. answer the "Why?" part) in the
commit log in the first place.

But I don't like adding module parameters unless with really good
reasons. And in this case there's no proper documentation when and how a
user should use the module parameter so this is nowhere near a proper
justifiction.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
