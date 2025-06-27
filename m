Return-Path: <linux-wireless+bounces-24610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2256AEB059
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 09:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C2E562BDB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 07:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BBE21C195;
	Fri, 27 Jun 2025 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b="IXAnLguu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.growora.pl (mail.growora.pl [51.254.119.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9231D5154
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.254.119.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010147; cv=none; b=BAi+04NxQh5jI1DZSkZPKzRMN955PFRA2dRhpLv2bReX7oqYvP6lgNK8lRb6wQSMqHPI6SGuQ7IXbXPEuBDshrGMgYdYnKFsTa0t8rKpvMHBc2puCiOkgpP0n9XoduZy9TOydTqf+/0ehuQPUmPitbBbxdguFSt8nGbD43Ergco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010147; c=relaxed/simple;
	bh=EB99enkNQ3/lKc2PdUObvM5/Gi3NF8gZrWwaTOp5KYs=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=Lz6ebq+yMsj3sSgcUOq9TJDxLOG292fPaT0lYwy/FoUEzl79USIbAiCLzUl5X0WkBNCOIDMAtMFHtihd2AqFoQSzceubtfg/PJrpkjfGpBroxK9lvdX+Cgvi3o30e3kxXyPYZFnp4ePhJXLiiOfULXHjYe2NvqMpCj/IQm9CJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl; spf=pass smtp.mailfrom=growora.pl; dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b=IXAnLguu; arc=none smtp.client-ip=51.254.119.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=growora.pl
Received: by mail.growora.pl (Postfix, from userid 1002)
	id 1FF1423299; Fri, 27 Jun 2025 09:41:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growora.pl; s=mail;
	t=1751010134; bh=EB99enkNQ3/lKc2PdUObvM5/Gi3NF8gZrWwaTOp5KYs=;
	h=Date:From:To:Subject:From;
	b=IXAnLguuMtXBTc4HhknqJ2P23K+VAbR+LLo6rthxU+pvc4c9O3ZffNGt2Q/PC5mSj
	 ziVfcGIkTS9ekBXVYYnS7orOWZ7ulY+ALy7XR7zScut6HDXmjk4zDA/qUYqZ3QdzZ4
	 2BWDpWcdybgichLGz9XMJxKd8R0Jejn1OHtGLyKT3vWUF2TjcypA5Sjj1Pzf1HLhuE
	 whnfqThF26kb+7Po68S83zdfZkoEZrbIxRIG/XS5G9OmCpu0B6WbQEuY7u54YFnxXs
	 hoq9AurcbvNNQDzT+dvdVbyhXinKj2FUp2uM19MU5PsUymJW0OZIESqWLlA3kkuMK7
	 R4UxuHtKad9Bw==
Received: by mail.growora.pl for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 07:40:49 GMT
Message-ID: <20250627084500-0.1.ka.221kg.0.fcomc35f7m@growora.pl>
Date: Fri, 27 Jun 2025 07:40:49 GMT
From: "Mateusz Hopczak" <mateusz.hopczak@growora.pl>
To: <linux-wireless@vger.kernel.org>
Subject: IT bez rekrutacji
X-Mailer: mail.growora.pl
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cze=C5=9B=C4=87,

wiem, =C5=BCe rozw=C3=B3j oprogramowania to dzi=C5=9B nie tylko kwestia t=
echnologii, ale tempa i dost=C4=99pno=C5=9Bci odpowiednich ludzi.=20

Je=C5=9Bli temat dotyczy r=C3=B3wnie=C5=BC Pa=C5=84stwa zespo=C5=82u, by=C4=
=87 mo=C5=BCe warto porozmawia=C4=87 o wsp=C3=B3=C5=82pracy, w kt=C3=B3re=
j to my przejmujemy ca=C5=82y proces tworzenia oprogramowania =E2=80=93 o=
d analizy po utrzymanie. Pracujemy elastycznie, dostosowuj=C4=85c si=C4=99=
 do wewn=C4=99trznych procedur i Waszego stacku technologicznego.

Dzia=C5=82amy tak, jakby=C5=9Bmy byli cz=C4=99=C5=9Bci=C4=85 zespo=C5=82u=
, ale bez operacyjnego ci=C4=99=C5=BCaru, ryzyka kosztownych rekrutacji, =
z elastycznym podej=C5=9Bciem i transparentnym modelem rozlicze=C5=84.

Czy jeste=C5=9Bcie Pa=C5=84stwo zainteresowani pog=C5=82=C4=99bieniem tem=
atu?


Pozdrawiam
Mateusz Hopczak

