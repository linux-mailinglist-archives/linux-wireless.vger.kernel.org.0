Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE252F671A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 18:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhANRNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 12:13:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbhANRNJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 12:13:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21D3D23B1C;
        Thu, 14 Jan 2021 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610644349;
        bh=P2CKuvPXVX1Am6zvxrbxWJQCeeQG3gHEoIcmlXsAOyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gxFumVRsvbe0M2xNMW66ltOrMtHs6320bGHDGOQA8s40Z5njTeKOsjF/WNT+3Mz2H
         mX6SjcLafMgymOit8qEKB6edl9FU9qVRdUIg7Uws8HeRp8gmjHR5b7zJ/8OJq/PSrm
         Psq4CePmoHIJo769T+aT/L6Fbj5TGwKtiN9S2bie7qgnz9HJj4BMtfc9xfZHteiaW5
         zxT9wKDLuqyksSahuYbcUkzqrjvCZqV7/VI8pSdXSxpBf67FJZJy571Gf/jDcd+zJp
         1Qo8XQXDzlZlaeTAipkk/4fMsY/+/A0TsB8pgeiX4XIHrOa8tIw4C4Yb9KSdbC9hGz
         adKGnuWUi099Q==
Date:   Thu, 14 Jan 2021 09:12:28 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, matthias_berndt@gmx.de, mozlima@gmail.com
Subject: Re: [PATCH wireless-drivers] mt7601u: fix rx buffer refcounting
Message-ID: <20210114091228.2b95fd4b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <62b2380c8c2091834cfad05e1059b55f945bd114.1610643952.git.lorenzo@kernel.org>
References: <62b2380c8c2091834cfad05e1059b55f945bd114.1610643952.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 14 Jan 2021 18:10:52 +0100 Lorenzo Bianconi wrote:
> Fix the following crash due to erroneous page refcounting:

Acked-by: Jakub Kicinski <kubakici@wp.pl>
